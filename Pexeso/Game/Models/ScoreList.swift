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
    static let instance = ScoreList()
    private let sheetId = "132a8EqBc3gaWjG_WDyomRXUdAgeHabrctqf7Ty1Qcvc"
    private let baseUrl = "https://sheets.googleapis.com/v4/spreadsheets"
    private let refreshToken: String = "1//06R9VVGihX5tVCgYIARAAGAYSNwF-L9IrJ-YXsAksygoKCmwMJIEDkISCOb42IQUwJqDebEAPzp_GA1FOjJSEdgXEluu0bPqHxmU"
    private let clientId = "731733503394-4rutqrq6cfeq1muufnoaqu11c5gd43ot.apps.googleusercontent.com"
    private let clientSecret = "niTDsKIxtO7GUWIXScqVQLRl"
    private let sheetRange = "A2:B10000"
    private var accessToken = "ya29.a0AfH6SMDyAo0Lb6cjmjhn23YQuYjkHs_jmV7RNzY3JNro0CWSe9OPfomDJy0dmVysBorG3-8OmROh2ZPrls-YZk8DVcNDGkXg7olNheQq_Sh546nPzy3lFrTy2yPgag8N6vm4rr9eoQTtfR1mzrSCVT8U_OEOkY06D7ys"
    private var authorized = false
    
    public var scores: [Score] = []
    
    private init() {
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
