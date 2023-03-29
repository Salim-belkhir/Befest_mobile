//
//  ContentView.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userMV: UserViewModel
    @ObservedObject var festivalVM: FestivalViewModel
    
    
    var body: some View {
        //TODO : En fonction du rôle display la bonne page
        if(userMV.id == 0){
            LogView()
                .environmentObject(userMV)
        }
        else{
            if(festivalVM.id == 0){
                ListFestivalsView()
                    .environmentObject(festivalVM)
                    .environmentObject(userMV)
            }
            else{
                if(userMV.role == "admin"){
                    AdminAppView()
                        .environmentObject(userMV)
                        .environmentObject(festivalVM)
                }
                else{
                    BenevoleAppView()
                        .environmentObject(userMV)
                        .environmentObject(festivalVM)
                }
            }
        }
    }
    
    //TODO: Enlever la création de l'admin et créer un utilisateur vide
    init(){
        self.userMV = UserViewModel(id: 1, firstname: "admin", lastname: "admin", email: "admin@gmail.com", password: "admin", role: "benevole")
        self.festivalVM = FestivalViewModel(id: 0, name: "", year: "", nbOfDays: 0, closed: false, numberOfBenevoles: 0)
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
