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
                        .padding(4)
                        .background(.purple)
                        .cornerRadius(2)
                }
        }
    }
    
}


struct DisconnectNavBar: View{
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View{
        HStack{
            Button(action: {
                let user = UserDTO(email: "", id: 0, firstname: "", lastname: "", password: "", role: "")
                userVM.state = .success(user)
                userVM.state = .ready
            })
            {
                Text("Se déconnecter")
                    .foregroundColor(.white)
                    .padding(4)
                    .background(.purple)
                    .cornerRadius(2)
            }
        }
    }
}
