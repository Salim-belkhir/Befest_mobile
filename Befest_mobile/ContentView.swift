//
//  ContentView.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        //TODO : En fonction du rôle display la bonne page
        if(true){
            LogView()
            //BenevoleAppView()
        }
        else{
            AdminAppView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
