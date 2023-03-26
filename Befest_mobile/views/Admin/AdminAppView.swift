//
//  AdminAppView.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI


struct AdminAppView: View {
    private var token: String;
    @EnvironmentObject var userMV: UserViewModel
    @EnvironmentObject var festivalVM: FestivalViewModel
    
    
    var body: some View {
        
        TabView {

            ListZonesView()
                .tabItem() {
                    NavBarItem(image: "map", description: "Zones")
                }
            
            Text("Rien a signaler ici")
                .tabItem() {
                    NavBarItem(image: "person.3", description: "Benevoles")
                }
            
            ListJoursView()
                .tabItem(){
                    NavBarItem(image: "calendar", description: "Jours")
                }
            
            EditFestivalView()
                .tabItem() {
                    NavBarItem(image: "info.circle.fill", description: "festival")
                }
        }
    }
    
    init(){
        self.token = UserDefaults.standard.string(forKey: "token") ?? "Null j'ai pas trouvé"
        //self.userDTO = UserDefaults.standard.object(forKey: "user") as! UserDTO
    }
}
