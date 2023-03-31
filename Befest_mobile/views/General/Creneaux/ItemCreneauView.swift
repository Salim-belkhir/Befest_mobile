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
    
    @State var showZones: Bool = false
    
    var body: some View {
        HStack{
            Text("Creneau \(creneau.heure_debut)-\(creneau.heure_fin)")
            Spacer()
            if(!showZones){
                Button(action:{
                    self.showZones = true
                })
                {
                    Image(systemName: "arrowtriangle.right.fill")
                }
            }
            else{
                Button(action: {
                    self.showZones = false
                })
                {
                    Image(systemName: "arrowtriangle.up.fill")
                }
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
