//
//  ItemCreneauView.swift
//  Befest_mobile
//
//  Created by etud on 29/03/2023.
//

import SwiftUI

struct ItemCreneauView: View {
    @ObservedObject var creneau: CreneauViewModel
    
    @ObservedObject var zoneList: ListZoneVM
    private var zoneListIntent: ZoneListIntent
    
    var body: some View {
        VStack{
            Section(header: Text("Creneau \(creneau.heure_debut)-\(creneau.heure_fin)")){
                
            }
        }
    }
    
    init(creneau: CreneauViewModel) {
        self.creneau = creneau
        let listOfZones = ListZoneVM()
        self.zoneList = listOfZones
        self.zoneListIntent = ZoneListIntent(listOfZones: listOfZones)
    }
}
