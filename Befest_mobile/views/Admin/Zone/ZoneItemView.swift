//
//  ZoneItemView.swift
//  Befest_mobile
//
//  Created by m1 on 26/03/2023.
//

import SwiftUI

struct ZoneItemView: View {
    @ObservedObject var zoneVM: ZoneViewModel
    
    var body: some View {
        HStack{
            Text(zoneVM.name)
            Text("Nombre de bénévoles nécessaires : \(zoneVM.number_benevoles_needed)")
        }
    }
    
    
    init(zone: ZoneViewModel){
        self.zoneVM = zone
    }
}

