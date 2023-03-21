//
//  FestivalService.swift
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

class FestivalService {
    static var urlFestival: String = ConfigAPI.apiUrl + "/festivals/"
    
    static func getAllFestivals() async -> [FestivalViewModel]? {
        do{
            let urlApi : URL = URL(string: urlFestival)!
            let festivals: [FestivalDTO] = try await URLSession.shared.getJSON(from: urlApi)
            return FestivalDTO.decodeFestival(data: festivals)
        }
        catch {
            print(error)
            return nil
        }
    }
}
