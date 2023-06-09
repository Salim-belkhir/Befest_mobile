//
//  AffectationService.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation


class AffectationService{
    
    //GET
    static func getAllAffectationsOfUser(user: Int, festival: Int) async throws -> [GetAffectationCreneauDTO]?{
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/affectations/user/"+String(user)+"/festival/"+String(festival))!
        let affectations: [GetAffectationCreneauDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return affectations
    }
    
    
    static func getAllAffectationOfZoneForCreneau(zone: Int, creneau: Int) async throws -> [GetAffectationUserDTO]? {
        let urlAPI: URL = URL(string: ConfigAPI.apiUrl+"/affectations/zone/"+String(zone)+"/creneau/"+String(creneau))!
        let affectationsUsers: [GetAffectationUserDTO] = try await URLSession.shared.getJSON(from: urlAPI)
        return affectationsUsers
    }
    
    //POST
    static func createAffectation(affectation: PostAffectationDTO) async throws{
        debugPrint(affectation.id_zone)
        debugPrint(affectation.id_user)
        debugPrint(affectation.id_creneau)
        
        let request = URLRequest.createRequest(urlStr: "/affectations/", method: "POST")
        guard let encoded = await JSONHelper.encode(data: affectation) else {
            throw RequestError.encodageProblem
        }
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //PUT
    static func updateAffectation(affectation: PostAffectationDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/affectations/"+String(affectation.id), method: "PUT")
        guard let encoded = await JSONHelper.encode(data: affectation) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //DELETE
    static func deleteAffectation(id: Int) async throws{
        let request = URLRequest.createRequest(urlStr: "/affectations/"+String(id), method: "DELETE")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
}
