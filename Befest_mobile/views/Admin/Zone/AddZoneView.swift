//
// AddZoneView.swift
// Befest_mobile
//
// Created by etud on 28/03/2023.
//

import SwiftUI

struct AddZoneView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel // Vue modèle pour le festival sélectionné
    @ObservedObject var zoneVM: ZoneViewModel // Vue modèle pour la zone à ajouter
    private var intent: ZoneIntent // Intention pour ajouter la zone

    less
    Copy code
    @State var name: String = "" // Nom de la zone
    @State var stepper_value: Int = 1 // Nombre de bénévoles nécessaires

    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Ajouter une zone")){
                        HStack{
                            Text("Nom de la zone: ")
                            TextField("", text: $name) // Champ de texte pour le nom de la zone
                        }
                        
                        HStack{
                            Text("Nombre de bénévoles nécessaires : \(stepper_value)")
                            Stepper("", value: $stepper_value, in: 1...100) // Stepper pour sélectionner le nombre de bénévoles nécessaires
                        }
                        
                        Button("Valider"){ // Bouton pour valider l'ajout de la zone
                            self.intent.changeName(name: name) // Modifier le nom de la zone dans l'intention
                            self.intent.changeNbBenevolesNeeded(number: stepper_value) // Modifier le nombre de bénévoles nécessaires dans l'intention
                            Task{
                                await self.intent.createZone(festival: festivalVM.id) // Ajouter la zone au festival sélectionné dans l'intention
                            }
                        }
                    }
                }
            }
        }
    }

    // Initialisation de la vue
    init(){
        let zoneView = ZoneViewModel(id: 0, name: "", number_benevoles_needed: 0) // Initialisation de la vue modèle pour la zone à ajouter
        self.zoneVM = zoneView
        self.intent = ZoneIntent(zoneVM: zoneView) // Initialisation de l'intention pour ajouter la zone
    }
}