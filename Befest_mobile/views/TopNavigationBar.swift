//
//  TopNavigationBar.swift
//  Befest_mobile
//
//  Created by m1 on 26/03/2023.
//

import SwiftUI
struct NameFestivalNavBar: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    
    var body: some View{
        HStack{
            Button(action: {
                let festival = FestivalDTO(id: 0, name: "", year: "", nbOfDays: 0, closed: false, countBenevoles: 0)
                festivalVM.state = .success(festival)
                festivalVM.state = .ready
            })
            {
                Text(festivalVM.name)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.purple)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.purple, lineWidth: 2)
                    )
                    .shadow(radius: 1)
            }
        }
    }
}

struct DisconnectNavBar: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var festivalVM: FestivalViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                UserDefaults.standard.set("", forKey: "token")
                let user = UserDTO(email: "", id: 0, firstname: "", lastname: "", password: "", role: "")
                userVM.state = .success(user)
                userVM.state = .ready
                let festival = FestivalDTO(id: 0, name: "", year: "", nbOfDays: 0, closed: false, countBenevoles: 0)
                festivalVM.state = .success(festival)
                festivalVM.state = .ready
            }) {
                
                Image(systemName: "person.crop.circle.fill.badge.xmark")
                .foregroundColor(.white)
                .padding(9)
                .background(.blue)
                .cornerRadius(15)
                .shadow(radius: 1)
            }
            Spacer() // Ajout de Spacer pour réduire la taille de l'HStack
        }
    }
}
