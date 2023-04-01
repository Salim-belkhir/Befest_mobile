//
//  CreneauListIntent.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import Foundation
import SwiftUI

struct CreneauListIntent{
    @ObservedObject var listCreneauVM: ListCreneauxVM
    
    
    init(listCreneauVM: ListCreneauxVM) {
        self.listCreneauVM = listCreneauVM
    }
    
    
    func getData(jour: Int) {
        Task{
            if(listCreneauVM.state == .ready){
                listCreneauVM.state = .loading
                do{
                    let creneaux: [GetCreneauDTO] = try await CreneauService.getAllCreneaux(jour: jour) ?? []
                    let creneauxVM: [CreneauViewModel] = GetCreneauDTO.decodeCreneau(data: creneaux) ?? []
                    listCreneauVM.state = .success(creneaux: creneauxVM)
                    listCreneauVM.state = .ready
                }
                catch{
                    debugPrint(error)
                    listCreneauVM.state = .error
                    listCreneauVM.state = .ready
                }
            }
            else{
                listCreneauVM.state = .error
                listCreneauVM.state = .ready
            }
        }
    }
    
    func getDataBen(jour: Int, user : Int) {
        Task{
            if(listCreneauVM.state == .ready){
                listCreneauVM.state = .loading
                do{
                    let creneaux: [GetCreneauDTO] = try await CreneauService.getAllCreneauxBen(jour: jour,user:user) ?? []
                    let creneauxVM: [CreneauViewModel] = GetCreneauDTO.decodeCreneau(data: creneaux) ?? []
                    listCreneauVM.state = .success(creneaux: creneauxVM)
                    listCreneauVM.state = .ready
                }
                catch{
                    debugPrint(error)
                    listCreneauVM.state = .error
                    listCreneauVM.state = .ready
                }
            }
            else{
                listCreneauVM.state = .error
                listCreneauVM.state = .ready
            }
        }
    }
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listCreneauVM.state == .ready){
            self.listCreneauVM.state = .moveCreneau(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listCreneauVM.state = .ready
        }
    }
        
     

    public func delete(at: IndexSet){
        Task{
            if(self.listCreneauVM.state == .ready){
                do{
                    try await CreneauService.deleteCreneau(id: self.listCreneauVM[at.first!].id)
                    self.listCreneauVM.state = .deleteCreneau(at: at)
                    self.listCreneauVM.state = .ready
                }
                catch{
                    self.listCreneauVM.state = .error
                    self.listCreneauVM.state = .ready
                }
                
            }
        }
    }
}
