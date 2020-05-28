//
//  Auth.swift
//  Pexeso
//
//  Created by Administlator on 2020/05/28.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let scope: String
    let token_type: String
}

class ApiClient {
    static let instance = ApiClient()
    
    /* FIXME: if you want to publish this app, implement oauth. */
    private let refreshToken: String = "1//06R9VVGihX5tVCgYIARAAGAYSNwF-L9IrJ-YXsAksygoKCmwMJIEDkISCOb42IQUwJqDebEAPzp_GA1FOjJSEdgXEluu0bPqHxmU"
    private let clientId = "731733503394-4rutqrq6cfeq1muufnoaqu11c5gd43ot.apps.googleusercontent.com"
    private let clientSecret = "niTDsKIxtO7GUWIXScqVQLRl"
    /* FIXME: if you want to publish this app, implement oauth. */
    
    private var accessToken: String?
    private var expiredAt :Date?
    
    public var authorized = false
    
    private init() {
        initTokenWithUserDefaults()
        confirmToken()
        sleep(1) // FIXME: make other requests wait for finishing to confirm.
    }
    
    public func getAccessToken() {
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
            self.storeToken(response: auth)
        }
        task.resume()
    }
    
    func handleResponse(response: URLResponse?) -> Bool {
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                return true
            }
            print(httpResponse)
        }
        return false
    }
    
    func isExpired () -> Bool {
        /* DEGBU */
        print(expiredAt ?? Date())
        print(Date())
        print(expiredAt ?? Date() <= Date())
        /* DEGBU */
        return expiredAt ?? Date() <= Date()
    }
    
    // FIXME: if you want to publish this app, store token as more secure storage like keychain.
    private func initTokenWithUserDefaults() {
        accessToken = UserDefaults.standard.object(forKey: "accessToken") as! String?
        expiredAt = UserDefaults.standard.object(forKey: "expiredAt") as! Date?
    }
    
    private func removeTokenInUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "expiredAt")
    }
    
    private func confirmToken() {
        if !isExpired() {
            return
        }
        getAccessToken()
    }
    
    // FIXME: if you want to publish this app, store token as more secure storage like keychain.
    private func storeToken(response: AuthResponse) {
        var date = Date()
        date.addTimeInterval(Double(response.expires_in))
        
        expiredAt = date
        accessToken = response.access_token
        
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(expiredAt, forKey: "expiredAt")
    }
    
    func prepare(endpoint: String, method: String, body: [String: Any]) -> URLRequest {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = method
        if (method != "GET") {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        let token = accessToken ?? ""
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        return request
    }
}
