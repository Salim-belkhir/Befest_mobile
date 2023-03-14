//
//  NavBar.swift
//  Befest_mobile
//
//  Created by etud on 14/03/2023.
//

import SwiftUI


struct Page {
    var image: String
    var description: String
    
    init(image: String, description: String) {
        self.image = image
        self.description = description
    }
}


extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}


struct NavBar: View {
    var pages: [Page] = [
        Page(image: "map", description: "Zones"),
        Page(image: "gamecontroller", description: "Jeux"),
        Page(image: "person.3", description: "Bénévoles"),
        Page(image: "calendar", description: "Planning"),
        Page(image: "person.crop.circle", description: "Compte")
    ]
    
    var body: some View {
        HStack{
            ForEach(pages, id: \.image) { item in
                NavBarItem(image: item.image, description: item.description)
            }
        }
        .padding()
        .background(Color.white)
        .frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight, alignment: .bottom)
    }
}



