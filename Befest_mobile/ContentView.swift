//
//  ContentView.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userMV: UserViewModel
    
    
    var body: some View {
        //TODO : En fonction du rôle display la bonne page
        if(userMV.id == 0){
            LogView()
                .environmentObject(userMV)
        }
        else{
            if(userMV.role == "admin"){
                AdminAppView()
                    .environmentObject(userMV)
            }
            else{
                BenevoleAppView()
                    .environmentObject(userMV)
            }
        }
    }
    
    
    init(){
        self.userMV = UserViewModel()
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
