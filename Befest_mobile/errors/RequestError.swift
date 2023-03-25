//
//  RequestError.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation

enum RequestError: Error, CustomStringConvertible {
    case encodageProblem
    case decodageProblem
    case requestError(String)
    
    var description: String {
        switch self{
        case .requestError(let error):
            return "The request failed. You can see below the reason: \n\(error)"
        case .encodageProblem:
            return "An error occured while encoding the data"
        case .decodageProblem:
            return "An error occured while decoding the data"
        }
    }
}
