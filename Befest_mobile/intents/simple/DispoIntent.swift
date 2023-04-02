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

    
    func createAffectation(idUser: Int,idZone: Int, idCreneau: Int)
    {
        Task{
            if(self.model.state == .ready){
                self.model.state = .loading
                do{
                    let affectationDTO = PostAffectationDTO(idUser: idUser, idZone: idZone, idCreneau: idCreneau)
                    try await AffectationService.createAffectation(affectation: affectationDTO)
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
    }
    
    func createDispo(dispo: PostDisponibiliteDTO){
        Task{
            do{
                try await DisponibiliteService.createDispo(dispo: dispo)
            }
            catch{
                debugPrint(error)
            }
        }
    }
    
    init(model: DisponibiliteViewModel){
        self.model = model
    }
}
