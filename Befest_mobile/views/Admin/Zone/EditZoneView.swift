//
//  EditZoneView.swift
//  Befest_mobile
//
//  Created by etud on 28/03/2023.
//

import SwiftUI

struct EditZoneView: View {
    @ObservedObject var zoneVM: ZoneViewModel // Le viewModel de la zone à modifier
    private var intent: ZoneIntent // L'intention de modifier la zone
    
    @State var name: String // Le nom modifié de la zone
    @State var stepper_value: Int // La valeur modifiée du nombre de bénévoles nécessaires
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Modifier la zone")){ // Section de modification de la zone
                        
                        // Champ de modification du nom de la zone
                        HStack{
                            Text("Nom de la zone: ")
                            TextField("", text: $name)
                        }
                        
                        // Champ de modification du nombre de bénévoles nécessaires
                        HStack{
                            Text("Nombre de bénévoles nécessaires : \(stepper_value)")
                            Stepper("", value: $stepper_value, in: 1...100)
                        }
                        
                        // Bouton pour valider les modifications apportées à la zone
                        Button("Valider"){
                            self.intent.changeName(name: name) // Modifier le nom de la zone dans l'intention
                            self.intent.changeNbBenevolesNeeded(number: stepper_value) // Modifier le nombre de bénévoles nécessaires dans l'intention
                            Task{
                                await self.intent.updateZone() // Mettre à jour la zone dans la base de données
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    init(zone: ZoneViewModel){
        self.zoneVM = zone // Initialiser le viewModel de la zone avec celui passé en paramètre
        self.intent = ZoneIntent(zoneVM: zone) // Initialiser l'intention de modifier la zone avec le viewModel de la zone
        self.stepper_value = zone.number_benevoles_needed // Initialiser la valeur du stepper avec le nombre de bénévoles nécessaires actuel de la zone
        self.name = zone.name // Initialiser le nom de la zone avec le nom actuel de la zone
    }
}