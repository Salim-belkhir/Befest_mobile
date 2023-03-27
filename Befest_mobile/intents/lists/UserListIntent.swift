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
    
    
    func getData() async {
        if(listBenevolesVM.state == .ready){
            listBenevolesVM.state = .loading
            do{
                let benevoles: [UserDTO] = try await UserService.getAllBenevoles() ?? []
                let benevolesVM: [UserViewModel] = UserDTO.decodeUser(data: benevoles) ?? []
                listBenevolesVM.state = .success(benevoles: benevolesVM)
                listBenevolesVM.state = .ready
            }
            catch{
                debugPrint("An error occured")
                listBenevolesVM.state = .error
                listBenevolesVM.state = .ready
            }
        }
        else{
            listBenevolesVM.state = .error
            listBenevolesVM.state = .ready
        }
    }
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listBenevolesVM.state == .ready){
            self.listBenevolesVM.state = .moveBenevole(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listBenevolesVM.state = .ready
        }
    }
        
}
