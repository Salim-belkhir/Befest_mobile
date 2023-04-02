//
//  BenevoleAppView.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI

struct BenevoleAppView: View {
    var body: some View {
        TabView {
            
            // On affiche la page des disponibilités du bénévole
            DispoBenevoleView()
                .tabItem(){
                    NavBarItem(image: "calendar", description: "Disponibilites")
                }
            // On affiche la page des affectations du bénévole
            AffectationPageView()
                .tabItem(){
                    NavBarItem(image: "list.dash", description: "Affectations")
                }
            // On affiche la page des informations du bénévole
            AccountView()
            
                .tabItem() {
                    NavBarItem(image: "person.crop.circle", description: "Mon compte")
                }
        }
    }
}
