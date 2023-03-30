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
    
    var colors = ["Red", "Green", "Blue", "Tartan"]
        @State private var selectedColor = "Red"

    
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
                    Button(action:
                    {
                        self.isSelected = true
                    })
                    {
                       Text("Affecter")
                    }
                    .padding(15)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    
                }
                else
                {
                    Button(action:{
                        self.isSelected = false
                    })
                    {
                        Image(systemName: "arrowtriangle.up.fill")
                    }
                    .padding(15)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                }
            }
            
            if(isSelected)
            {
                
                Section(header: Text("jsnqkjdnze"))
                {
                    Picker("Choisir une zone", selection: $zone_selected)
                    {
                        ForEach(listZones.listOfZones, id: \.self) { item in // 4
                            Text(item.name) // 5
                        }
                        .contentShape(Rectangle())
                    }
                    
                }
            }
            
            Spacer().frame(height: 30)
            VStack()
            {
                
                Text(zone_selected.name)
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
