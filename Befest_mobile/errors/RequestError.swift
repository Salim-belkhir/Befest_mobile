//
//  RequestError.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation

enum RequestError: Error {
    case encodageProblem(String)
    case requestError(String)
    case requestFailed(String)
}
