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
            guard (tdata.id != 0 && tdata.firstname != "" && tdata.lastname != "" && tdata.email != "" && tdata.password != "") else{
               return nil
            }
            let id : Int = tdata.id
            let user = UserViewModel(id: id, firstname: tdata.firstname, lastname: tdata.lastname, email: tdata.email, password: tdata.password ?? "", role: tdata.role ?? "")
            users.append(user)
        }
        return users
    }
    
    var email: String
    var id: Int
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
    public var id : Int = 0;
    @Published var firstname : String = "";
    @Published var lastname : String = "";
    @Published var email : String = "";
    @Published var password : String = "";
    public var role : String = "";
    
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
            case .clearInformations:
                self.lastname = ""
                self.firstname = ""
                self.email = ""
                self.password = ""
                self.role = ""
                
            case .error:
                debugPrint("An error occured")
            default:
                break
            }
        }
    }
    
    init(id: Int, firstname: String, lastname: String, email: String, password: String, role: String) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.role = role
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
    case clearInformations
    
    
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
        case (.clearInformations, .clearInformations):
            return true
        default:
            return false
        }
    }
}
