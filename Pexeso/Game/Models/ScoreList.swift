//
//  Score.swift
//

//
//  Created by Administlator on 2020/05/28.
//

import Foundation

struct Score: Codable {
    let name: String
    let score: Int
}

struct ScoreResponse: Codable {
    let range: String
    let majorDimension: String
    let values: [[String]]
}

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
    
    public func calcScore(name: String, matchCount: Int, mistakeCount: Int, timeRemain: Int) -> Score {
        var sum = matchCount * 10
        sum -= sum - (5 * mistakeCount)
        if timeRemain >= 4000 {
            sum += 100
        }
        if timeRemain >= 4000 {
            sum += 100
        }
        let score = Score(name: name, score: sum)
        return score
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
                list.append(Score(name: row[0], score: Int(row[1]) ?? 0))
            }
            self.client.authorized = true
            self.scores = list
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
        scores.sort { (a, b) in return a.score < b.score }
    }
    
    private func toArray() -> [Any] {
        var list : [Any] = []
        for item in scores {
            list.append([item.name, item.score])
        }
        return list
    }
}
