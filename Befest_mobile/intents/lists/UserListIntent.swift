//
//  UserListIntent.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import Foundation
import SwiftUI

struct UserListIntent{
    @ObservedObject var listBenevolesVM: BenevolesListVM
    
    
    init(listBenevoles: BenevolesListVM) {
        self.listBenevolesVM = listBenevoles
    }
    
    
    func getData() {
        Task{
            if(listBenevolesVM.state == .ready){
                listBenevolesVM.state = .loading
                do{
                    let benevoles: [UserDTO] = try await UserService.getAllBenevoles() ?? []
                    let benevolesVM: [UserViewModel] = UserDTO.decodeUser(data: benevoles) ?? []
                    listBenevolesVM.state = .success(benevoles: benevolesVM)
                    listBenevolesVM.state = .ready
                }
                catch{
                    debugPrint(error)
                    listBenevolesVM.state = .error
                    listBenevolesVM.state = .ready
                }
            }
            else{
                listBenevolesVM.state = .error
                listBenevolesVM.state = .ready
            }
        }
    }
    
    func getDataForCreneauForZone(zone: Int, creneau: Int){
        Task{
            if(listBenevolesVM.state == .ready){
                listBenevolesVM.state = .loading
                do{
                    let benevolesDTO: [GetAffectationUserDTO] = try await AffectationService.getAllAffectationOfZoneForCreneau(zone: zone, creneau: creneau) ?? []
                    
                    let benevoles = GetAffectationUserDTO.decodeUser(data: benevolesDTO) ?? []
                    listBenevolesVM.state = .success(benevoles: benevoles)
                    listBenevolesVM.state = .ready
                }
                catch{
                    debugPrint(error)
                    listBenevolesVM.state = .error
                    listBenevolesVM.state = .ready
                }
            }
        }
    }
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listBenevolesVM.state == .ready){
            self.listBenevolesVM.state = .moveBenevole(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listBenevolesVM.state = .ready
        }
    }
        
}
