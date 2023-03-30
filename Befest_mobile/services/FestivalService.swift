//
//  FestivalService.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation



class FestivalService {
    //GET
    static func getAllFestivals() async throws -> [FestivalViewModel]? {
        let urlApi : URL = URL(string: ConfigAPI.apiUrl + "/festivals/")!
        let festivals: [FestivalDTO] = try await URLSession.shared.getJSON(from: urlApi)
        return FestivalDTO.decodeFestival(data: festivals)
    }
    
    //DELETE
    static func deleteFestival(id: Int) async throws{
        let request: URLRequest = URLRequest.createRequest(urlStr: "/festivals/"+String(id), method: "DELETE")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpresponse = response as! HTTPURLResponse
        
        if(httpresponse.statusCode != 200){
            throw RequestError.requestError("Error \(httpresponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
        }
    }
    
    //PUT
    static func closeFestival(id: Int) async throws{
        let request: URLRequest = URLRequest.createRequest(urlStr: "/festivals/\(String(id))/close", method: "PUT")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        
        if(httpResponse.statusCode != 200){
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
        
        debugPrint(httpResponse.statusCode)
    }
    
    //POST
    static func createFestival(festival: FestivalDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/festivals/", method: "POST")
        guard let encoded = await JSONHelper.encode(data: festival) else {
            throw RequestError.encodageProblem
        }
        let (_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 201 {
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
    
    //PUT
    static func updateFestival(festival: FestivalDTO) async throws{
        let request = URLRequest.createRequest(urlStr: "/festivals/"+String(festival.id), method: "PUT")
        guard let encoded = await JSONHelper.encode(data: festival) else {
            throw RequestError.encodageProblem
        }
        let(_, response) = try await URLSession.shared.upload(for: request, from: encoded)
        
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 201{
            throw RequestError.requestError("Error \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
        }
    }
}
