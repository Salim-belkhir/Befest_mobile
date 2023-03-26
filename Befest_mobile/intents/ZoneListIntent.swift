//
//  ZoneListIntent.swift
//  Befest_mobile
//
//  Created by m1 on 26/03/2023.
//

import Foundation
import SwiftUI

struct ZoneListIntent{
    @ObservedObject var listOfZones: ListZoneVM
    
    
    init(listOfZones: ListZoneVM) {
        self.listOfZones = listOfZones
    }
    
    
    func getData(festival: Int) async {
        if(listOfZones.state == .ready){
            listOfZones.state = .loading
            do{
                let zones: [ZoneDTO] = try await ZoneService.getAllZones(festival: festival) ?? []
                let zonesVM: [ZoneViewModel] = ZoneDTO.decodeZone(data: zones) ?? []
                listOfZones.state = .success(zones: zonesVM)
                listOfZones.state = .ready
            }
            catch{
                debugPrint("An error occured")
                listOfZones.state = .error
                listOfZones.state = .ready
            }
        }
        else{
            listOfZones.state = .error
            listOfZones.state = .ready
        }
    }
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listOfZones.state == .ready){
            self.listOfZones.state = .moveZone(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listOfZones.state = .ready
        }
    }
        
     
    //TODO: décommenter la ligne pour réellement supprimer les données
    public func delete(at: IndexSet) async{
        if(self.listOfZones.state == .ready){
            do{
                try await ZoneService.deleteZone(id: self.listOfZones[at.first!].id)
                self.listOfZones.state = .deleteZone(at: at)
                self.listOfZones.state = .ready
            }
            catch{
                self.listOfZones.state = .error
                self.listOfZones.state = .ready
            }
            
        }
    }
}
