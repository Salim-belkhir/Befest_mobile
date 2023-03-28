//
//  AddFestivalView.swift
//  Befest_mobile
//
//  Created by etud on 28/03/2023.
//

import SwiftUI

struct AddZoneView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var zoneVM: ZoneViewModel
    private var intent: ZoneIntent
    
    @State var name: String = ""
    @State var stepper_value: Int = 1
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Ajouter une zone")){
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
                                await self.intent.createZone(festival: festivalVM.id)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    init(){
        let zoneView = ZoneViewModel(id: 0, name: "", number_benevoles_needed: 0)
        self.zoneVM = zoneView
        self.intent = ZoneIntent(zoneVM: zoneView)
    }
    
}
