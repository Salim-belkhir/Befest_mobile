//
//  ItemDispoView.swift
//  Befest_mobile
//
//  Created by etud on 30/03/2023.
//

import SwiftUI

struct ItemDispoView: View {
    @State var isSelected: Bool = false
    @ObservedObject var dispoVM: DisponibiliteViewModel
    @State var zone_selected: ZoneViewModel = ZoneViewModel(id: 0, name: "Vide", number_benevoles_needed: 2)
    @ObservedObject var listZones: ListZoneVM
    private var intent: ZoneListIntent
    @EnvironmentObject var festivalVM: FestivalViewModel
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "clock")
                VStack{
                    Text(dispoVM.creneau?.jour_name ?? "")
                    Text("\(dispoVM.creneau?.heure_debut ?? "") - \(dispoVM.creneau?.heure_fin ?? "")")
                }
                
                Spacer()
                
                if(!isSelected){
                    Button("Affecter"){
                        self.isSelected = true
                    }
                }
                else{
                    Button(action:{
                        self.isSelected = false
                    })
                    {
                        Image(systemName: "arrowtriangle.up.fill")
                    }
                }
                
            }
            
            if(isSelected){
                
                Spacer().frame(height: 100)
                
                HStack{
                    Picker("Veuillez choisir une zone", selection: $zone_selected){
                        ForEach(listZones.listOfZones, id: \.id){ zone in
                            Text(zone.name)
                        }
                    }
                    
                    Button("Valider"){
                        debugPrint("Cliqué")
                    }
                }
                
                
                Text(self.zone_selected.name)
            }
        }
        .onAppear(){
            self.intent.getData(festival: festivalVM.id)
        }
    }
    
    init(dispo: DisponibiliteViewModel){
        self.dispoVM = dispo
        let listZones = ListZoneVM()
        self.listZones = listZones
        self.intent = ZoneListIntent(listOfZones: listZones)
    }
}
