//
//  JeuModel.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import Foundation


class Jeu: Codable {
    private var _id: String
    private var name: String
    private var type: String
    
    init(_id: String, name: String, type: String) {
        self._id = _id
        self.name = name
        self.type = type
    }
}
