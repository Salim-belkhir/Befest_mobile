//
//  DispoItemView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct DispoItemView: View {
    @ObservedObject var disponibiliteVM: DisponibiliteViewModel
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(.purple)
                Text(disponibiliteVM.creneau?.jour_name ?? "Pas de nom")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer().frame(height: 10)
            HStack{
                Spacer().frame(width: 10)
                Image(systemName: "clock.fill")
                Text("\(disponibiliteVM.creneau?.heure_debut ?? "Pas de heure de début")-\(disponibiliteVM.creneau?.heure_fin ?? "Pas de heure de fin")")
                Spacer()
            }
            .foregroundColor(.gray)
        }
    }
}
