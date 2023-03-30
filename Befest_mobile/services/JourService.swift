//
//  JourService.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation


class JourService{
    //GET
    static func getAllJours(festival: Int) async throws -> [GetJourDTO]?{
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/jours/festival/"+String(festival))!
        let jours: [GetJourDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return jours
    }
    
    //POST
    static func createJour(jour: GetJourDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/jours/", method: "POST")
        guard let encoded = await JSONHelper.encode(data: jour) else {
            throw RequestError.encodageProblem
        }
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //PUT
    static func updateJour(jour: GetJourDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/jours/"+String(jour.id), method: "PUT")
        guard let encoded = await JSONHelper.encode(data: jour) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //DELETE
    static func deleteJour(id: Int) async throws{
        let request = URLRequest.createRequest(urlStr: "/jours/"+String(id), method: "DELETE")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
}
