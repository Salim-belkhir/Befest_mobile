//
//  UserService.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation


class UserService{
    //GET
    static func getAllBenevoles() async throws -> [UserDTO]?{
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl + "/users/benevoles")!
        let benevoles: [UserDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return benevoles
    }
    
    //Update
    static func updateUser(user: UserDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/users/"+String(user.id), method: "PUT")
        guard let encoded = await JSONHelper.encode(data: user) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
}
