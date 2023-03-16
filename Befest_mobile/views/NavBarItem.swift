//
//  NavBarItem.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import SwiftUI


func actionNull() -> Void {
    print("Q")
}

struct NavBarItem: View {
    var image: String
    var description: String
    var action: ()->Void
    
    var body: some View {
        VStack{
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 40)
                
            Text(description)
                .font(.system(size: 13))
        }
        .frame(maxWidth: 500)
    }
    
    init(image: String, description: String) {
        self.image = image
        self.description = description
        self.action = actionNull
    }
}
