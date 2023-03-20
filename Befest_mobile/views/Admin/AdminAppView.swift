//
//  AdminAppView.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI


struct AdminAppView: View {
    var body: some View {
        
        TabView {

            BenevolesVew()
                .tabItem() {
                    NavBarItem(image: "map", description: "Zones")
                }
            
            BenevolesVew()
                .tabItem() {
                    NavBarItem(image: "person.3", description: "Benevoles")
                }
            
            BenevolesVew()
                .tabItem(){
                    NavBarItem(image: "calendar", description: "Jours")
                }
            
            BenevolesVew()
                .tabItem() {
                    NavBarItem(image: "info.circle.fill", description: "festival")
                }
        }
    }
}
