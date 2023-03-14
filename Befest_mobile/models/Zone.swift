//
//  Zone.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import Foundation


class Zone: Codable {
    private var _id: String
    private var name: String
    private var jeux: [Jeu]
    
    init(_id: String, name: String, jeux: [Jeu]){
        self._id = _id
        self.name = name
        self.jeux = jeux
    }
}
