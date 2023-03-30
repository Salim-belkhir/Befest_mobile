//
//  SelectorZoneView.swift
//  Befest_mobile
//
//  Created by etud on 30/03/2023.
//

import SwiftUI

struct SelectorZoneView: View {
    @ObservedObject var listZones: ListZoneVM
    @Binding var zone_selected: ZoneViewModel
    private var intent: ZoneListIntent
    private var festivalId: Int
    
    var body: some View {
        Group{
            Picker("Please choose a zone", selection: $zone_selected){
                ForEach(listZones.listOfZones, id: \.id){  zone in
                    Text(zone.name)
                }
            }
            .onAppear{
                self.intent.getData(festival: festivalId)
            }
        }
    }
    
    
    init(festival: Int){
        let listZones = ListZoneVM()
        self.listZones = listZones
        self.intent = ZoneListIntent(listOfZones: listZones)
        self.festivalId = festival
    }
}

