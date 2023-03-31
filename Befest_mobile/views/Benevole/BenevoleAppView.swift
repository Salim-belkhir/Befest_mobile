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
            
            
            Text("Affectations")
                .tabItem(){
                    NavBarItem(image: "list.dash", description: "Affectations")
                }
            
            
            
            Text("Mon compte")
                .tabItem() {
                    NavBarItem(image: "person.crop.circle", description: "Mon compte")
                }
        }
    }
}
