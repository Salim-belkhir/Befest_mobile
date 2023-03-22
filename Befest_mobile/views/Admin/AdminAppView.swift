//
//  AdminAppView.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI


struct AdminAppView: View {
    private var token: String;
    private var userDTO: UserDTO;
    
    
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
            
            VStack{
                Text("Token")
                Text(self.token)
                Text(self.userDTO.firstname)
            }
                .tabItem(){
                    NavBarItem(image: "calendar", description: "Jours")
                }
            
            BenevolesVew()
                .tabItem() {
                    NavBarItem(image: "info.circle.fill", description: "festival")
                }
        }
    }
    
    init(){
        self.token = UserDefaults.standard.string(forKey: "token") ?? "Null j'ai pas trouvé"
        self.userDTO = UserDefaults.standard.object(forKey: "user") as! UserDTO
    }
}
