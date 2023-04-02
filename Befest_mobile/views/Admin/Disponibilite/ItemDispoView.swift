//
//  ItemDispoView.swift
//  Befest_mobile
//
//  Created by etud on 30/03/2023.
//

import SwiftUI
struct ItemDispoView: View {
    @ObservedObject var dispoVM: DisponibiliteViewModel
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "clock")
                VStack{
                    Text(dispoVM.creneau?.jour_name ?? "")
                    Text("\(dispoVM.creneau?.heure_debut ?? "") - \(dispoVM.creneau?.heure_fin ?? "")")
                }
                Spacer()
            }
        }
    }
    
    init(dispo: DisponibiliteViewModel){
        self.dispoVM = dispo
    }
}
