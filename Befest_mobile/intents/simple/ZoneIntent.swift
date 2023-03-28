//
//  ZOneIntent.swift
//  Befest_mobile
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI


struct ZoneIntent{
    @ObservedObject var model: ZoneViewModel
    
    func changeName(name: String){
        if(self.model.state == .ready){
            self.model.state = .changeName(name)
            self.model.state = .ready
        }
    }
    
    func changeNbBenevolesNeeded(number: Int){
        if(model.state == .ready){
            model.state = .changeNbBenevolesNeeded(number)
            model.state = .ready
        }
    }
    
    
    func createZone(festival: Int) async{
        if(self.model.state == .ready){
            self.model.state = .loading
            do{
                let zoneDTO = ZoneDTO(id: self.model.id, name: self.model.name, nbBenevolesNeeded: self.model.number_benevoles_needed, festival_zone: festival)
                try await ZoneService.createZone(zone: zoneDTO)
                self.model.state = .success
                self.model.state = .ready
            }
            catch{
                debugPrint(error)
                self.model.state = .error
                self.model.state = .ready
            }
        }
    }
    
    
    func updateZone() async {
        if(self.model.state == .ready){
            self.model.state = .loading
            do{
                let zoneDTO = ZoneDTO(id: self.model.id, name: self.model.name, nbBenevolesNeeded: self.model.number_benevoles_needed, festival_zone: 0)
                try await ZoneService.updateZone(zone: zoneDTO)
                self.model.state = .success
                self.model.state = .ready
            }
            catch{
                debugPrint(error)
                self.model.state = .error
                self.model.state = .ready
            }
        }
    }
    
    
    
    init(zoneVM: ZoneViewModel){
        self.model = zoneVM
    }
}
