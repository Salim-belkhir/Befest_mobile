//
//  AuthService.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation

extension URLSession{
  func getJSON<T: Decodable>(
    from url: URL) async throws -> T {
        let (data, _) = try await data(from: url)
        let decoder = JSONDecoder() // création d'un décodeur
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}




class AuthService{
    static func signin(user: UserDTO) async throws {
        do{
            var request = URLRequest(url: ConfigAPI.apiUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let encoded = await JSONHelper.encode(data: user) else {
                throw RequestError.encodageProblem("GoRest: pb encodage")
            }
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode != 200{
                throw RequestError.requestError("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
        }
        catch{
            throw RequestError.requestFailed("Request Failed")
        }
        
        
        
    }
}

