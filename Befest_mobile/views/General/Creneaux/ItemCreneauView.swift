//
//  ItemCreneauView.swift
//  Befest_mobile
//
//  Created by etud on 29/03/2023.
//

import SwiftUI

struct ItemCreneauView: View {
    @ObservedObject var creneau: CreneauViewModel
    
    var body: some View {
        HStack{
            Image(systemName: "clock")
            VStack{
                Text(creneau.jour_name ?? "")
                Text("\(creneau.heure_debut) - \(creneau.heure_fin)")
            }
            
            Spacer()
            
            Button("Affecter"){
                
            }
        }
    }
    
    init(creneau: CreneauViewModel) {
        self.creneau = creneau
    }
}
