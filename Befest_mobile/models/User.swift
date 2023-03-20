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
            guard (tdata.id != nil && tdata.firstname != nil && tdata.lastname != nil && tdata.email != nil) else{
               return nil
            }
            let id : String = tdata.id!
            let user = UserViewModel(id: id, firstname: tdata.firstname! , lastname: tdata.lastname!, email: tdata.email!)
            users.append(user)
        }
        return users
    }
    
    var email: String?
    var id: String?
    var firstname: String?
    var lastname: String?
    var password: String?
    
    
}

class UserViewModel : ObservableObject, Equatable {
    @Published var id : String?;
    @Published var firstname : String?;
    @Published var lastname : String?;
    @Published var email : String?;
    @Published var password : String?;
    
    @Published var state : UserState = .ready {
        didSet{
            switch state {
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
    
    init(id: String, firstname: String, lastname: String, email: String) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
    
    
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}


enum UserState : Equatable {
    static func == (lhs: UserState, rhs: UserState) -> Bool {
        switch(lhs, rhs){
        case (.ready, .ready):
            return true
        case (.ready, .loading):
            return false
        case(.success(let lhsSuccess), .success(let rhsSuccess)):
            return lhsSuccess.id == rhsSuccess.id
        case (.loading, _):
            return false
        case (.error(_), .ready):
            return false
        case (.error(_), .loading):
            return false
        case (.error(_), .success(_)):
            return false
        case (.success(_), .ready):
            return false
        case (.success(_), .loading):
            return false
        case (.success(_), .error(_)):
            return false
        case (.ready, .success(_)):
            return false
        case (.ready, .error(_)):
            return false
        case (.error(_), .error(_)):
            return true
        }
    }
    
    case ready
    case loading
    case success(UserDTO)
    case error(UserIntentError)
}
