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
}
