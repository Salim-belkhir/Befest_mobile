//
//  User.swift
//  Befest_mobile
//
//  Created by etud on 16/03/2023.
//

import Foundation


struct UserDTO: Decodable {
    static func decodeUser(data : [UserDTO]) -> [User]?{
        var users = [User]()
        for tdata in data{
            guard (tdata._id != "") else{
               return nil
            }
            let id : String = tdata._id
            let user = User(id: id, email: tdata.email)
            users.append(user)
        }
        return users
    }
    
    var email: String
    var _id: String
    
    
}

class User {
    private var id : String;
    private var prenom : String?;
    private var nom : String?;
    private var email : String;
    
    init(id: String, prenom: String? = nil, nom: String? = nil, email: String) {
        self.id = id
        self.prenom = prenom
        self.nom = nom
        self.email = email
    }
}
