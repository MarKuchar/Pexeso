//
//  Score.swift
//

//
//  Created by Administlator on 2020/05/28.
//

import Foundation

class ScoreList {
    static let instance = ScoreList()
    private let client = ApiClient.instance
    
    private let sheetId = "132a8EqBc3gaWjG_WDyomRXUdAgeHabrctqf7Ty1Qcvc"
    private let baseUrl = "https://sheets.googleapis.com/v4/spreadsheets"
    private let sheetRange = "A2:B10000"
    
    public var scores: [Score] = []
    
    private init() {
        self.get()
    }
    
    public func get() {
        let endpoint = baseUrl + "/" + sheetId + "/values/" + sheetRange
        
        let request = client.prepare(endpoint: endpoint, method: "GET", body: [:] as [ String: Any])
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            if !self.client.handleResponse(response: response) {
                return
            }
            guard let _data = data else { return }
            
            let scoreResponse = try! JSONDecoder().decode(ScoreResponse.self, from: _data)
            var list: [Score] = []
            for row in scoreResponse.values {
                list.append(Score(name: row[0], value: Int(row[1]) ?? 0))
            }
            self.client.authorized = true
            self.scores = list
            self.sortByScore()
        }
        task.resume()
    }
    
    public func putAndReplace(item: Score) {
        scores.append(item)
        sortByScore()
        let endpoint = baseUrl + "/" + sheetId + "/values/" + sheetRange + "?valueInputOption=RAW"
        let jsonBody: [ String: Any ] = [
            "values": toArray()
        ]
        let request = self.client.prepare(endpoint: endpoint, method: "PUT", body: jsonBody)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func sortByScore() {
        scores.sort { (a, b) in return a.value > b.value }
    }
    
    private func toArray() -> [[String]] {
        var list : [[String]] = []
        for item in scores {
            list.append([item.name, String(item.value)])
        }
        return list
    }
}
