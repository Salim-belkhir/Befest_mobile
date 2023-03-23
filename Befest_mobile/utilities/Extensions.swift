//
//  RequestHelper.swift
//  Befest_mobile
//
//  Created by etud on 23/03/2023.
//

import Foundation


extension URLRequest{
    static func createRequest(urlStr: String, method: String) -> URLRequest {
        let new_url : URL = URL(string: ConfigAPI.apiUrl + urlStr)!
        var request = URLRequest(url: new_url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}



extension URLSession{
  func getJSON<T: Decodable>(
    from url: URL) async throws -> T {
        let (data, _) = try await data(from: url)
        let decoder = JSONDecoder() // création d'un décodeur
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}
