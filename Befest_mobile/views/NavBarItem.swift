//
// NavBarItem.swift
// Befest_mobile
//
// Created by etud on 14/03/2023.
//

import SwiftUI

// Définition de la fonction actionNull qui ne fait que d'afficher "Q" dans la console
func actionNull() -> Void {
    print("Q")
}

struct NavBarItem: View {
    var image: String
    var description: String
    var action: ()->Void

    // Création d'une icône avec une légende et une action à exécuter
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

    // Initialisation de NavBarItem avec une image et une description, si aucune action n'est spécifiée, la fonction actionNull est utilisée
    init(image: String, description: String) {
        self.image = image
        self.description = description
        self.action = actionNull
    }
}