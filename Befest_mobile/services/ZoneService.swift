//
//  ZoneService.swift
//  Befest_mobile
//
//  Created by etud on 23/03/2023.
//

import Foundation


class ZoneService{
    //GET
    static func getAllZones(festival: Int) async throws -> [ZoneDTO]?{
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/zones/festival/"+String(festival))!
        let zones: [ZoneDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return zones
    }
    
    //POST
    static func createZone(zone: ZoneDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/zones/", method: "POST")
        guard let encoded = await JSONHelper.encode(data: zone) else {
            throw RequestError.encodageProblem
        }
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //PUT
    static func updateZone(zone: ZoneDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/zones/"+String(zone.id), method: "PUT")
        guard let encoded = await JSONHelper.encode(data: zone) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //DELETE
    static func deleteZone(id: Int) async throws{
        let request = URLRequest.createRequest(urlStr: "/zones/"+String(id), method: "DELETE")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
}
