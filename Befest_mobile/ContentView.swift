//
//  ContentView.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
    //@State var linkSelected : 
    
    
    var body: some View {
        /*NavigationStack{
            Text("ggded")
            NavigationLink(destination: BenevolesVew()){
                Text("hdhdhd")
            }
            
        
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar){
                        NavBar()
                    }
                }
        }*/
        
        TabView{
            NavBar()
                .tabItem(){
                    NavBarItem(image: "globe", description: "planete")
                }
    
            BenevolesVew()
                .tabItem(){
                    Text("benevole")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
