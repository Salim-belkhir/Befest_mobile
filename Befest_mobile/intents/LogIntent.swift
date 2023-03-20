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
    
    func signin() async {
        self.model.state = .loading
        let userDTO : UserDTO = UserDTO(email: self.model.email, password: self.model.password)
        do{
            try await AuthService.signin(user: userDTO)
            self.model.state = .success(userDTO)
        }
        catch{
            print("An error occured")
            self.model.state = .error(.errorLoading)
        }
        
    }
    
    
    func signup(firstname: String, lastname: String, email: String, password: String){
        
    }
    
}
