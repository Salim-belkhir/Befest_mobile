//
//  AuthService.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation



class AuthService{
    
    static func signin(user: UserDTO) async throws -> UserDTO {
        let request : URLRequest = URLRequest.createRequest(urlStr: "/auth/signin", method: "POST")
        guard let encoded = await JSONHelper.encode(data: user) else {
            throw RequestError.encodageProblem
        }
        let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
        guard let decoded: UserDTO = await JSONHelper.decode(data: data) else {
            throw RequestError.decodageProblem
        }
        UserDefaults.standard.set(decoded.token, forKey: "token")
        UserDefaults.standard.set(data, forKey: "user")
        let httpresponse = response as! HTTPURLResponse
        
        if httpresponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
        }
        return decoded
    }
    
    
    static func signup(user: UserDTO) async throws {
        let request : URLRequest = URLRequest.createRequest(urlStr: "/auth/signup", method: "POST")
        guard let encoded = await JSONHelper.encode(data: user) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpresponse = response as! HTTPURLResponse
        
        if(httpresponse.statusCode != 201){
            throw RequestError.requestError("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
        }
    }
}

