//
// SearchBar.swift
// Befest_mobile
//
// Created by etud on 24/03/2023.
//

import SwiftUI

struct SearchBar: View {
    // Binding pour maintenir la valeur du texte de recherche
    @Binding var text: String

    // Booléen pour suivre si la barre de recherche est en mode édition
    @State private var isEditing = false

    var body: some View {
        HStack {
            
            // Textfield pour saisir le texte de recherche
            TextField("Rechercher ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        // Loupe pour lancer la recherche
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        // Bouton pour effacer le texte de recherche
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

            // Bouton "Cancel" pour annuler la recherche
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""

                }) {
                    Text("Annuler")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }   
    }
}