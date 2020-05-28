//
//  Score.swift
//  Pexeso
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

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let scope: String
    let token_type: String
}



class ScoreList {
    let sheetId = "132a8EqBc3gaWjG_WDyomRXUdAgeHabrctqf7Ty1Qcvc"
    let baseUrl = "https://sheets.googleapis.com/v4/spreadsheets"
    let refreshToken: String = "1//06R9VVGihX5tVCgYIARAAGAYSNwF-L9IrJ-YXsAksygoKCmwMJIEDkISCOb42IQUwJqDebEAPzp_GA1FOjJSEdgXEluu0bPqHxmU"
    let clientId = "731733503394-4rutqrq6cfeq1muufnoaqu11c5gd43ot.apps.googleusercontent.com"
    let clientSecret = "niTDsKIxtO7GUWIXScqVQLRl"
    let sheetRange = "A2:B10000"
    private var accessToken = "ya29.a0AfH6SMBCZzhjP8xqBG2JvrWwdHzQG8ymzqsHuvNbO59YmbuDBy1Mq8egD3iJ8k53mjCi61JBywdLXuEoFLhhoCc_60jNWGyJP1wKmIOkEuIrgXwfVlndpUdaAYPiWTL4H3Fqi9P7H3zvx8Nn_xoH2Gu8qSm0Jk9q_ha3"
    private var authorized = false
    public var scores: [Score] = []
    
    init() {
        // self.getToken() TODO: store token to device
        self.get()
    }
    
    public func get() {
        let endpoint = baseUrl + "/" + sheetId + "/values/" + sheetRange
        
        let request = prepare(endpoint: endpoint, method: "GET", body: [:] as [ String: Any])
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            if !self.handleResponse(response: response) {
                return
            }
            guard let _data = data else { return }
            self.authorized = true
            
            let scoreResponse = try! JSONDecoder().decode(ScoreResponse.self, from: _data)
            var list: [Score] = []
            for row in scoreResponse.values {
                list.append(Score(name: row[0], score: Int(row[1]) ?? 0))
            }
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
        let request = prepare(endpoint: endpoint, method: "PUT", body: jsonBody)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func getToken() {
        let endpoint = "https://oauth2.googleapis.com/token"
        let jsonBody: [ String: Any ] = [
            "clientId": clientId,
            "clientSecret": clientSecret,
            "grantType": "refresh_token",
            "refreshToken": refreshToken
        ]
        let request = prepare(endpoint: endpoint, method: "POST", body: jsonBody)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            if !self.handleResponse(response: response) {
                return
            }
            guard let _data = data else { return }
            
            let auth = try! JSONDecoder().decode(AuthResponse.self, from: _data)
            self.accessToken = auth.access_token
        }
        task.resume()
    }
    
    private func handleResponse(response: URLResponse?) -> Bool {
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                return true
            }
            print(httpResponse)
        }
        return false
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
    
    private func prepare(endpoint: String, method: String, body: [String: Any]) -> URLRequest {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = method
        if (method != "GET") {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        return request
    }
}
