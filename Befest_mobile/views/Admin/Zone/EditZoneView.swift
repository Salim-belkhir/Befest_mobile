//
//  EditZoneView.swift
//  Befest_mobile
//
//  Created by etud on 28/03/2023.
//

import SwiftUI

struct EditZoneView: View {
    @ObservedObject var zoneVM: ZoneViewModel
    private var intent: ZoneIntent
    
    @State var name: String
    @State var stepper_value: Int
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Modifier la zone")){
                        HStack{
                            Text("Nom de la zone: ")
                            TextField("", text: $name)
                        }
                        
                        HStack{
                            Text("Nombre de bénévoles nécessaires : \(stepper_value)")
                            Stepper("", value: $stepper_value, in: 1...100)
                        }
                        
                        Button("Valider"){
                            self.intent.changeName(name: name)
                            self.intent.changeNbBenevolesNeeded(number: stepper_value)
                            Task{
                                await self.intent.updateZone()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    init(zone: ZoneViewModel){
        self.zoneVM = zone
        self.intent = ZoneIntent(zoneVM: zone)
        self.stepper_value = zone.number_benevoles_needed
        self.name = zone.name
    }
}
