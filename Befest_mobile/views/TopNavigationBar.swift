//
// TopNavigationBar.swift
// Befest_mobile
//
// Created by m1 on 26/03/2023.
//

import SwiftUI

struct NameFestivalNavBar: View {
    // On crée une variable qui va contenir le viewModel du festival
    @EnvironmentObject var festivalVM: FestivalViewModel

    var body: some View{
        HStack{
            // Bouton pour afficher le nom du festival courant
            Button(action: {
                // Création d'un nouvel objet FestivalDTO vide et affectation de cet objet au FestivalViewModel
                let festival = FestivalDTO(id: 0, name: "", year: "", nbOfDays: 0, closed: false, countBenevoles: 0)
                festivalVM.state = .success(festival)
                // Affectation de l'état "ready" au FestivalViewModel pour réinitialiser la vue
                festivalVM.state = .ready
            })
            {
                // Affichage du nom du festival courant
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
    // On crée une variable qui va contenir le viewModel de l'utilisateur
    @EnvironmentObject var userVM: UserViewModel
    // On crée une variable qui va contenir le viewModel du festival
    @EnvironmentObject var festivalVM: FestivalViewModel
    
    var body: some View {
        HStack {
            // Bouton pour déconnecter l'utilisateur
            Button(action: {
                // Réinitialisation du token de l'utilisateur
                UserDefaults.standard.set("", forKey: "token")
                // Création d'un nouvel objet UserDTO vide et affectation de cet objet au UserViewModel
                let user = UserDTO(email: "", id: 0, firstname: "", lastname: "", password: "", role: "")
                userVM.state = .success(user)
                // Affectation de l'état "ready" au UserViewModel pour réinitialiser la vue
                userVM.state = .ready
                // Création d'un nouvel objet FestivalDTO vide et affectation de cet objet au FestivalViewModel
                let festival = FestivalDTO(id: 0, name: "", year: "", nbOfDays: 0, closed: false, countBenevoles: 0)
                festivalVM.state = .success(festival)
                // Affectation de l'état "ready" au FestivalViewModel pour réinitialiser la vue
                festivalVM.state = .ready
            }) {
                // Affichage de l'icône de déconnexion
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