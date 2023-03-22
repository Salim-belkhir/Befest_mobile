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
    
    func signin() async {
        if(self.model.state != .ready){
            return
        }
        self.model.state = .loading
        let userDTO : UserDTO = UserDTO(email: self.model.email, id:"", firstname: "", lastname: "", password: self.model.password)
        do{
            try await AuthService.signin(user: userDTO)
            self.model.state = .success(userDTO)
            debugPrint("J\'ai recuperer les données")
        }
        catch{
            debugPrint("An error occured")
            debugPrint(error)
            self.model.state = .error(.errorLoading)
        }
        
    }
    
    
    func signup() async{
        if(self.model.state != .ready){
            return
        }
        self.model.state = .loading
        let userDTO : UserDTO = UserDTO(email: self.model.email, id:"", firstname: self.model.firstname, lastname: self.model.lastname, password: self.model.password)
        do{
            try await AuthService.signup(user: userDTO)
            self.model.state = .success(userDTO)
            debugPrint("J\'ai recuperer les données")
        }
        catch{
            debugPrint("An error occured")
            debugPrint(error)
            self.model.state = .error(.errorLoading)
        }
    }
    
}
