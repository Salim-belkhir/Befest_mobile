//
//  User.swift
//  Befest_mobile
//
//  Created by etud on 16/03/2023.
//

import Foundation


struct UserDTO: Decodable, Encodable {
    static func decodeUser(data : [UserDTO]) -> [UserViewModel]?{
        var users = [UserViewModel]()
        for tdata in data{
            guard (tdata.id != "" && tdata.firstname != "" && tdata.lastname != "" && tdata.email != "" && tdata.password != "") else{
               return nil
            }
            let id : String = tdata.id
            let user = UserViewModel(id: id, firstname: tdata.firstname, lastname: tdata.lastname, email: tdata.email, password: tdata.password ?? "")
            users.append(user)
        }
        return users
    }
    
    var email: String
    var id: String
    var firstname: String
    var lastname: String
    var password: String? = nil
    var token: String? = nil
    var role: String? = nil
}


struct LogDTO: Decodable{
    var token: String
}

class UserViewModel : ObservableObject, Equatable {
    @Published var id : String = "";
    @Published var firstname : String = "";
    @Published var lastname : String = "";
    @Published var email : String = "";
    @Published var password : String = "";
    
    @Published var state : UserState = .ready {
        didSet{
            switch state {
            case .changeEmail(let email):
                self.email = email
            case .success(let user):
                self.lastname = user.lastname
                self.firstname = user.firstname
                self.email = user.email
                self.id = user.id
                
            case .error:
                debugPrint("An error occured")
            default:
                break
            }
        }
    }
    
    init(id: String, firstname: String, lastname: String, email: String, password: String) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
    }
    
    init() {}
    
    
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}


enum UserState: Equatable {
    case ready
    case loading
    case success(UserDTO)
    case error(UserIntentError)
    case changeEmail(String)
    
    
    static func == (lhs: UserState, rhs: UserState) -> Bool {
        switch(lhs, rhs){
        case (.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.success(_), .success(_)):
            return true
        case (.error(_), .error(_)):
            return true
        case (.changeEmail(_), .changeEmail(_)):
            return true
        default:
            return false
        }
    }
}
