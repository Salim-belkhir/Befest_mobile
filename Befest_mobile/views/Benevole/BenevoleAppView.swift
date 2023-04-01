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
            
            
            DispoBenevoleView()
                .tabItem(){
                    NavBarItem(image: "calendar", description: "Disponibilites")
                }
            
            AffectationPageView()
                .tabItem(){
                    NavBarItem(image: "list.dash", description: "Affectations")
                }
            AccountView()
            
                .tabItem() {
                    NavBarItem(image: "person.crop.circle", description: "Mon compte")
                }
        }
    }
}
