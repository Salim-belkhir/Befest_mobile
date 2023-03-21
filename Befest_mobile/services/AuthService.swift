//
//  AuthService.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation



class AuthService{
    
    static func signin(user: UserDTO) async throws {
        do{
            let urlSignin : URL = URL(string: ConfigAPI.apiUrl + "/auth/signin")!
            var request = URLRequest(url: urlSignin)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: user) else {
                throw RequestError.encodageProblem("GoRest: pb encodage")
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            guard let decoded: LogDTO = await JSONHelper.decode(data: data) else {
                return
            }
            UserDefaults.standard.set(decoded.token, forKey: "token")
            let httpresponse = response as! HTTPURLResponse
            
            if httpresponse.statusCode != 200{
                throw RequestError.requestError("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
            
            debugPrint("Réussi !")
        }
        catch{
            throw RequestError.requestFailed("Request Failed")
        }
    }
    
    
    static func signup(user: UserDTO) async throws {
        do{
            let urlSignup : URL = URL(string: ConfigAPI.apiUrl + "/auth/signup")!
            var request = URLRequest(url: urlSignup)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

