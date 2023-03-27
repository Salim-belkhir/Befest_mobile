//
//  JourListIntent.swift
//  Befest_mobile
//
//  Created by m1 on 26/03/2023.
//

import Foundation
import SwiftUI

struct JourListIntent{
    @ObservedObject var listOfJours: ListJoursVM
    
    
    init(listJours: ListJoursVM) {
        self.listOfJours = listJours
    }
    
    
    func getData(festival: Int) async {
        if(listOfJours.state == .ready){
            listOfJours.state = .loading
            do{
                let jours: [GetJourDTO] = try await JourService.getAllJours(festival: festival) ?? []
                let joursVM = GetJourDTO.decodeJour(data: jours) ?? []
                listOfJours.state = .success(jours: joursVM)
                listOfJours.state = .ready
            }
            catch{
                debugPrint("An error occured")
                listOfJours.state = .error
                listOfJours.state = .ready
            }
        }
        else{
            listOfJours.state = .error
            listOfJours.state = .ready
        }
    }
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listOfJours.state == .ready){
            self.listOfJours.state = .moveJour(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listOfJours.state = .ready
        }
    }
        
     
    //TODO: décommenter la ligne pour réellement supprimer les données
    public func delete(at: IndexSet) async{
        if(self.listOfJours.state == .ready){
            do{
                try await JourService.deleteJour(id: self.listOfJours[at.first!].id)
                self.listOfJours.state = .deleteJour(at: at)
                self.listOfJours.state = .ready
            }
            catch{
                self.listOfJours.state = .error
                self.listOfJours.state = .ready
            }
            
        }
    }
    
}
