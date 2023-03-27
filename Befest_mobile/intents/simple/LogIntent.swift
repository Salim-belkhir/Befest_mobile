//
//  LogIntent.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI


struct LogIntent {
    @ObservedObject var model: UserViewModel
    
    init(model: UserViewModel) {
        self.model = model
    }
    
    func changeEmail(email: String){
        if(self.model.state == .ready){
            self.model.state = .changeEmail(email)
            self.model.state = .ready
        }
    }
    
    func clearInformations(){
        if(self.model.state == .ready){
            self.model.state = .clearInformations
            self.model.state = .ready
        }
    }
    
    
    func signin() async -> Bool{
        if(self.model.state != .ready){
            return false
        }
        self.model.state = .loading
        let userDTO : UserDTO = UserDTO(email: self.model.email, id:0, firstname: "", lastname: "", password: self.model.password)
        do{
            let userDTO = try await AuthService.signin(user: userDTO)
            self.model.state = .success(userDTO)
            self.model.state = .ready
            return true
        }
        catch{
            debugPrint(error)
            self.model.state = .error(.errorLoading)
            self.model.state = .ready
            return false
        }
    }
    
    
    func signup() async -> Bool{
        if(self.model.state != .ready){
            return false
        }
        self.model.state = .loading
        let userDTO : UserDTO = UserDTO(email: self.model.email, id:0, firstname: self.model.firstname, lastname: self.model.lastname, password: self.model.password, role: "benevole")
        do{
            try await AuthService.signup(user: userDTO)
            self.model.state = .clearInformations
            self.model.state = .ready
            return true
        }
        catch{
            debugPrint(error)
            self.model.state = .error(.errorLoading)
            self.model.state = .ready
            return false
        }
    }
    
}
