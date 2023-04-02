//
// AdminAppView.swift
// Befest_mobile
//
// Created by m1 on 20/03/2023.
//

import SwiftUI

struct AdminAppView: View {
    // Stocke le jeton d'authentification de l'utilisateur connecté
    private var token: String;
    // Récupère le ViewModel de l'utilisateur connecté
    @EnvironmentObject var userMV: UserViewModel
    // Récupère le ViewModel du festival en cours
    @EnvironmentObject var festivalVM: FestivalViewModel

    var body: some View {
        
        // Création d'un onglet à chaque vue pour la navigation
        TabView {
            // Navigation vers la vue de la liste des zones
            ListZonesView()
                .tabItem() {
                    // Création d'un bouton de navigation avec une icône et une description pour chaque onglet
                    NavBarItem(image: "map", description: "Zones")
                }
            // Navigation vers la vue de la liste des benevoles
            ListBenevolesView()
                .tabItem() {
                    NavBarItem(image: "person.3", description: "Benevoles")
                }
            // Navigation vers la vue de la liste des jours
            ListJoursView()
                .tabItem(){
                    NavBarItem(image: "calendar", description: "Jours")
                }
            // Navigation vers la vue des informations du festival
            EditFestivalView()
                .tabItem() {
                    NavBarItem(image: "info.circle.fill", description: "festival")
                }
        }
    }

    init(){
        // Récupère le jeton d'authentification de l'utilisateur stocké dans UserDefaults, sinon stocke la chaîne de caractères "Null j'ai pas trouvé"
        self.token = UserDefaults.standard.string(forKey: "token") ?? "Null j'ai pas trouvé"
        // Récupère l'objet UserDTO stocké dans UserDefaults et le stocke dans le ViewModel de l'utilisateur connecté
        //self.userDTO = UserDefaults.standard.object(forKey: "user") as! UserDTO
    }
}



