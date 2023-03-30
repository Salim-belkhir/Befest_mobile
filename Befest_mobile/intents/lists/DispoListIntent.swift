//
//  DispoListIntent.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import Foundation
import SwiftUI


struct DispoListIntent{
    @ObservedObject var listOfDispos: ListDisponibilitesVM
    
    
    init(listOfDispos: ListDisponibilitesVM) {
        self.listOfDispos = listOfDispos
    }
    
    
    func getDataUser(user: Int, festival: Int) {
        Task{
            if(listOfDispos.state == .ready){
                listOfDispos.state = .loading
                do{
                    debugPrint("Voici ce que je veux recuperer")
                    let dispos: [GetDispoCreneauDTO] = try await DisponibiliteService.getAllDisposUser(user: user, festival: festival) ?? []
                    let disposVM: [DisponibiliteViewModel] = GetDispoCreneauDTO.decodeDispo(data: dispos) ?? []
                    listOfDispos.state = .success(dispos: disposVM)
                    listOfDispos.state = .ready
                }
                catch{
                    debugPrint(error)
                    debugPrint("An error occured")
                    listOfDispos.state = .error
                    listOfDispos.state = .ready
                }
            }
            else{
                listOfDispos.state = .error
                listOfDispos.state = .ready
            }
        }
    }
    
    
    func getDataCreneau(creneau: Int) async {
        if(listOfDispos.state == .ready){
            listOfDispos.state = .loading
            do{
                let dispos: [GetDispoUserDTO] = try await DisponibiliteService.getAllDispoCreneau(creneau: creneau) ?? []
                let disposVM: [DisponibiliteViewModel] = GetDispoUserDTO.decodeDispo(data: dispos) ?? []
                listOfDispos.state = .success(dispos: disposVM)
                listOfDispos.state = .ready
            }
            catch{
                debugPrint(error)
                listOfDispos.state = .error
                listOfDispos.state = .ready
            }
        }
        else{
            listOfDispos.state = .error
            listOfDispos.state = .ready
        }
    }
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listOfDispos.state == .ready){
            self.listOfDispos.state = .moveDispo(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listOfDispos.state = .ready
        }
    }
        
     
    //TODO: décommenter la ligne pour réellement supprimer les données
    public func delete(at: IndexSet) async{
        if(self.listOfDispos.state == .ready){
            do{
                try await DisponibiliteService.deleteDispo(id: self.listOfDispos[at.first!].id)
                self.listOfDispos.state = .deleteDispo(at: at)
                self.listOfDispos.state = .ready
            }
            catch{
                self.listOfDispos.state = .error
                self.listOfDispos.state = .ready
            }
            
        }
    }
}
