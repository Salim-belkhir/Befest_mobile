//
//  SelectorZoneView.swift
//  Befest_mobile
//
//  Created by etud on 30/03/2023.
//

import SwiftUI

/*
struct SelectorZoneView: View {
    @ObservedObject var listZones: ListZoneVM
    @Binding var zone_selected: String
    private var intent: ZoneListIntent
    @EnvironmentObject var festivalVM: FestivalViewModel
    
    var body: some View {
        Group{
            Picker("Please choose a zone", selection: $zone_selected){
                ForEach(listZones.listOfZones, id: \.id){  zone in
                    Text(zone.name)
                }
            }
            .onAppear{
                self.intent.getData(festival: festivalVM.id)
            }
        }
    }
    
    
    init(){
        let listZones = ListZoneVM()
        self.listZones = listZones
        self.intent = ZoneListIntent(listOfZones: listZones)
    }
}
*/
