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
                .frame(width: 60, height: 70)
            Text(description)
                .font(.system(size: 14))
        }
        .frame(maxWidth: 500)
    }
    
    init(image: String, description: String) {
        self.image = image
        self.description = description
        self.action = actionNull
    }
}
