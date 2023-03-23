//
//  BenevolesVew.swift
//  Befest_mobile
//
//  Created by etud on 16/03/2023.
//

import SwiftUI

struct BenevolesVew: View {
    @EnvironmentObject var userMV: UserViewModel
    
    var body: some View {
        VStack{
            Text("Bienvenue sur la page des bénévoles")
            Text("Voici ton role: \(userMV.role)")
        }
    }
}

