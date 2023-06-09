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
    var password: String?
    var token: String?
    var role: String?
    
    init(email: String, id: Int, firstname: String, lastname: String, password: String){
        self.email = email
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
    }
    
    init(email: String, id: Int, firstname: String, lastname: String, password: String, role: String){
        self.email = email
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.role = role
    }}


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
    
    private var observers: [BenevoleVMObserver] = []
    
    @Published var state : UserState = .ready {
        didSet{
            switch state {
            case .changeEmail(let email):
                self.email = email
                notifyAll()
            case .success(let user):
                self.lastname = user.lastname
                self.firstname = user.firstname
                self.email = user.email
                self.id = user.id
                self.password = user.password!
                self.role = user.role!
                notifyAll()
            case .clearInformations:
                self.lastname = ""
                self.firstname = ""
                self.email = ""
                self.password = ""
                self.role = ""
                notifyAll()
                
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
    
    func notifyAll(){
        for o in self.observers{
            o.updated(id: self.id, model: self)
        }
    }
    
    
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}


enum UserState: Equatable {
    case ready
    case loading
    case success(UserDTO)
    case error
    case changeEmail(String)
    case clearInformations
    case update
    
    
    static func == (lhs: UserState, rhs: UserState) -> Bool {
        switch(lhs, rhs){
        case (.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.success(_), .success(_)):
            return true
        case (.changeEmail(_), .changeEmail(_)):
            return true
        case (.clearInformations, .clearInformations):
            return true
        case (.update, .update) :
            return true
        case (.error,.error) :
            return true
        default:
            return false
        }
    }
}
