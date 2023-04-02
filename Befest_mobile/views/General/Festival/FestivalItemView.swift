//
// FestivalItemList.swift
// Befest_mobile
//
// Created by m1 on 20/03/2023.
//

import SwiftUI

struct FestivalItemView: View {
    @EnvironmentObject var userMV: UserViewModel // Model pour gérer les informations de l'utilisateur
    @EnvironmentObject var festivalVM: FestivalViewModel // Model pour gérer les festivals
    @ObservedObject var festivalVMItem: FestivalViewModel // Model pour un festival individuel
    private var intent: FestivalIntent // Intent pour modifier les festivals
    private var colorBtn: Color { // Couleur du bouton "Choisir" ou "Fermé"
        return (self.festivalVMItem.closed ? .red : .green)
    }

    private var textButton: String{ // Texte sur le bouton "Choisir" ou "Fermé"
        return ((self.festivalVMItem.closed && self.userMV.role == "benevole") ? "Fermé" : "Choisir")
    }

    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(festivalVMItem.name) // Nom du festival
                        .foregroundColor(.blue)
                        .bold()
                        .font(.system(size: 17))
                    Spacer()
                    Text("Année: \(festivalVMItem.year)") // Année du festival
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                HStack{
                    Image(systemName: "person.3.fill") // Icône de nombre de participants
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text("\(self.festivalVMItem.numberOfBenevoles) participants") // Nombre de participants
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
            }
            
            Button(action: {
                self.intent.changeMainFestival(oldFestival: festivalVM) // Action pour changer le festival principal
            }, label: {
                Text(textButton) // Texte sur le bouton
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .bold()
                    .padding(8)
                    .background(colorBtn) // Couleur du bouton
                    .cornerRadius(16)
                    .frame(width: 80)
            })
            .disabled(self.festivalVMItem.closed && self.userMV.role == "benevole") // Empêche le bouton d'être cliqué si le festival est fermé et que l'utilisateur est un bénévole
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.4),radius: 1) // Ombre autour de l'élément
        
    }

    init(festivalVMItem: FestivalViewModel) {
        self.festivalVMItem = festivalVMItem
        self.intent = FestivalIntent(model: festivalVMItem)
    }
}