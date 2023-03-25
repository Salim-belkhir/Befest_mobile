//
//  DisponibiliteService.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation


class DisponibiliteService{
    //GET
    static func getAllDisposUser(user: Int) async throws -> [GetDispoUserDTO]?{
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/disponibilites/user/"+String(user))!
        let dispos: [GetDispoUserDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return dispos
    }
    
    //GET
    static func getAllDispoCreneau(creneau: Int) async throws -> [GetDispoCreneauDTO]? {
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/disponibilites/creneau/"+String(creneau))!
        let dispos: [GetDispoCreneauDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return dispos
    }
    
    //POST
    static func createDispo(dispo: PostDisponibiliteDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/disponibilites/", method: "POST")
        guard let encoded = await JSONHelper.encode(data: dispo) else {
            throw RequestError.encodageProblem
        }
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //PUT
    static func updateDispo(dispo: PostDisponibiliteDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/disponibilites/"+String(dispo.id), method: "PUT")
        guard let encoded = await JSONHelper.encode(data: dispo) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //DELETE
    static func deleteDispo(id: Int) async throws{
        let request = URLRequest.createRequest(urlStr: "/disponibilites/"+String(id), method: "DELETE")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
}
