//
//  FestivalService.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation



class FestivalService {
    static var urlFestival: String = ConfigAPI.apiUrl + "/festivals/"
    
    static func getAllFestivals() async throws -> [FestivalViewModel]? {
        let urlApi : URL = URL(string: urlFestival)!
        let festivals: [FestivalDTO] = try await URLSession.shared.getJSON(from: urlApi)
        debugPrint(festivals)
        return FestivalDTO.decodeFestival(data: festivals)
    }
    
    
    static func deleteFestival(id: Int) async throws{
        let request: URLRequest = URLRequest.createRequest(urlStr: "/festivals/"+String(id), method: "DELETE")
        let (_, response) = try await URLSession.shared.data(for: request)
        let httpresponse = response as! HTTPURLResponse
        
        if(httpresponse.statusCode != 200){
            throw RequestError.requestFailed("Request Failed")
        }
    }
}
