//
//  DispoIntent.swift
//  Befest_mobile
//
//  Created by etud on 30/03/2023.
//

import Foundation
import SwiftUI


struct DispoIntent{
    @ObservedObject var model: DisponibiliteViewModel
    
    func getZone(festival: Int){
        Task{
            if(self.model.state == .ready){
                self.model.state = .loading
                do{
                    let zonesDTO: [ZoneDTO] = try await ZoneService.getAllZones(festival: festival) ?? []
                    let zonesVM: [ZoneViewModel] = ZoneDTO.decodeZone(data: zonesDTO) ?? []
                    
                }
                catch{
                    debugPrint(error)
                    self.model.state = .error
                    self.model.state = .ready
                }
            }
        }
    }
    
    
    
    init(model: DisponibiliteViewModel){
        self.model = model
    }
}
