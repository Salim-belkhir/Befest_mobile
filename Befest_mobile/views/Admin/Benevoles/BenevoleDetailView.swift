//
//  BenevoleDetailView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct BenevoleDetailView: View {
    @ObservedObject var benevole: UserViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text(benevole.lastname)
                
                Text(benevole.firstname)
                
                
                Section(header: Text("Ses disponibilités")){
                    ListDispoView(user: benevole.id)
                }
            }
            .navigationTitle("Détails")
        }
        
    }
    
    
    init(benevole : UserViewModel){
        self.benevole = benevole
    }
}

