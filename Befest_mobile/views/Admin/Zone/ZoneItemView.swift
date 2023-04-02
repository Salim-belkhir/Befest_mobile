//
//  ZoneItemView.swift
//  Befest_mobile
//
//  Created by m1 on 26/03/2023.
//

import SwiftUI

struct ZoneItemView: View {
    @ObservedObject var zoneVM: ZoneViewModel // ZoneViewModel est un ObservableObject, donc on peut l'observer
    
    var body: some View {
        VStack(alignment: .leading){
            Text(zoneVM.name) // On affiche le nom de la zone
            Spacer().frame(height: 5)
            Text("Nombre de bénévoles nécessaires : \(zoneVM.number_benevoles_needed)")
                .font(.system(size: 12))
        }
    }
    
    // Initialisation de la vue
    init(zone: ZoneViewModel){
        self.zoneVM = zone
    }
}

