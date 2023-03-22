//
//  AuthService.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation



class AuthService{
    
    static func createRequest(urlStr: String) -> URLRequest {
        let new_url : URL = URL(string: ConfigAPI.apiUrl + urlStr)!
        var request = URLRequest(url: new_url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
    static func signin(user: UserDTO) async throws {
        let request : URLRequest = createRequest(urlStr: "/auth/signin")
        guard let encoded = await JSONHelper.encode(data: user) else {
            throw RequestError.encodageProblem("GoRest: pb encodage")
        }
        let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
        guard let decoded: UserDTO = await JSONHelper.decode(data: data) else {
            throw RequestError.requestFailed("Erreur dans le décodage")
        }
        debugPrint(decoded.id)
        UserDefaults.standard.set(decoded.token, forKey: "token")
        let httpresponse = response as! HTTPURLResponse
        
        if httpresponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
        }
    }
    
    
    static func signup(user: UserDTO) async throws {
        let request : URLRequest = createRequest(urlStr: "/auth/signup")
        guard let encoded = await JSONHelper.encode(data: user) else {
            throw RequestError.encodageProblem("Erreur dans l'encodage")
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpresponse = response as! HTTPURLResponse
        
        if(httpresponse.statusCode != 201){
            throw RequestError.requestError("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
        }
    }
}

