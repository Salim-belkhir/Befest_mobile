//
//  CreneauService.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation



class CreneauService{
    //GET
    static func getAllCreneaux(jour: Int) async throws -> [GetCreneauDTO]?{
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/creneaux/jour/"+String(jour))!
        let creneaux: [GetCreneauDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return creneaux
    }
    
    static func getAllCreneauxBen(jour: Int,user:Int) async throws -> [GetCreneauDTO]?{
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/creneaux/jour/"+String(jour)+"/user/"+String(user))!
        let creneaux: [GetCreneauDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return creneaux
    }
    
    //POST
    static func createCreneau(creneau: PostCreneauDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/creneaux/", method: "POST")
        guard let encoded = await JSONHelper.encode(data: creneau) else {
            throw RequestError.encodageProblem
        }
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //PUT
    static func updateCreneau(creneau: PostCreneauDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/creneaux/"+String(creneau.id), method: "PUT")
        guard let encoded = await JSONHelper.encode(data: creneau) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //DELETE
    static func deleteCreneau(id: Int) async throws{
        let request = URLRequest.createRequest(urlStr: "/creneaux/"+String(id), method: "DELETE")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
}
