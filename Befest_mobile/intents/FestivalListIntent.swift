//
//  FestivalListIntent.swift
//  Befest_mobile
//
//  Created by etud on 23/03/2023.
//

import Foundation
import SwiftUI



struct FestivalListIntent{
    @ObservedObject var listOfFestivals: FestivalListVM
    
    
    init(listFestivals: FestivalListVM) {
        self.listOfFestivals = listFestivals
    }
    
    
    func getData() async {
        if(listOfFestivals.state == .ready){
            listOfFestivals.state = .loading
            do{
                let festivals: [FestivalViewModel] = try await FestivalService.getAllFestivals() ?? []
                listOfFestivals.state = .success(festivals: festivals)
                listOfFestivals.state = .ready
            }
            catch{
                debugPrint("An error occured")
                listOfFestivals.state = .error
                listOfFestivals.state = .ready
            }
        }
        else{
            listOfFestivals.state = .error
            listOfFestivals.state = .ready
        }
    }
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        if(self.listOfFestivals.state == .ready){
            self.listOfFestivals.state = .moveFestival(fromOffsets: fromOffsets, toOffset: toOffset)
            self.listOfFestivals.state = .ready
        }
    }
        
     
    //TODO: décommenter la ligne pour réellement supprimer les données
    public func delete(at: IndexSet) async{
        if(self.listOfFestivals.state == .ready){
            do{
                //try await FestivalService.deleteFestival(id: self.listOfFestivals[at.first!].id)
                self.listOfFestivals.state = .deleteFestival(at: at)
                self.listOfFestivals.state = .ready
            }
            catch{
                self.listOfFestivals.state = .error
                self.listOfFestivals.state = .ready
            }
            
        }
    }
}
