//
//  AffectationListIntent.swift
//  Befest_mobile
//
//  Created by m1 on 02/04/2023.
//

import Foundation
import SwiftUI

struct AffectationListIntent{
    @ObservedObject var listAffectationVM: ListAffectationsVM
    
    
    init(listAffectationVM: ListAffectationsVM) {
        self.listAffectationVM = listAffectationVM
    }
    
    
    func getData(user: Int, festival: Int) {
        Task{
            if(listAffectationVM.state == .ready){
                listAffectationVM.state = .loading
                do{
                    let affectationsDTO: [GetAffectationCreneauDTO] = try await AffectationService.getAllAffectationsOfUser(user: user, festival: festival) ?? []
                    let affectations: [AffectationViewModel] = GetAffectationCreneauDTO.decodeData(data: affectationsDTO) ?? []
                    listAffectationVM.state = .success(affectations: affectations)
                    listAffectationVM.state = .ready
                }
                catch{
                    debugPrint(error)
                    listAffectationVM.state = .error
                    listAffectationVM.state = .ready
                }
            }
            else{
                listAffectationVM.state = .error
                listAffectationVM.state = .ready
            }
        }
    }
    

    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listAffectationVM.state == .ready){
            self.listAffectationVM.state = .moveAffectation(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listAffectationVM.state = .ready
        }
    }
        
     

    public func delete(at: IndexSet){
        Task{
            if(self.listAffectationVM.state == .ready){
                do{
                    debugPrint(self.listAffectationVM[at.first!].id)
                    try await AffectationService.deleteAffectation(id: self.listAffectationVM[at.first!].id)
                    self.listAffectationVM.state = .deleteAffectation(at: at)
                    self.listAffectationVM.state = .ready
                }
                catch{
                    debugPrint(error)
                    self.listAffectationVM.state = .error
                    self.listAffectationVM.state = .ready
                }
                
            }
        }
    }
}

