//
//  FestivalIntent.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation
import SwiftUI


struct FestivalIntent{
    @ObservedObject var model: FestivalViewModel
    
    public func changeName(name: String){
        if(self.model.state == .ready){
            self.model.state = .changeName(name)
            self.model.state = .ready
        }
    }
    
    public func changeYear(year: String){
        if(self.model.state == .ready){
            self.model.state = .changeYear(year)
            self.model.state = .ready
        }
    }
    
    
    public func changeNbOfDays(number: Int){
        if(self.model.state == .ready){
            self.model.state = .changeNbOfDays(number)
            self.model.state = .ready
        }
    }
    
    public func updateYear(year: String){
        
    }
    
    public func createFestival() async{
        do{
            debugPrint(self.model.nbOfDays, self.model.name, self.model.year)
            let festivalDTO: FestivalDTO = FestivalDTO(id: 0, name: self.model.name, year: self.model.year, nbOfDays: self.model.nbOfDays, closed: false, countBenevoles: 0)
            try await FestivalService.createFestival(festival: festivalDTO)
            self.model.state = .successCreate
            self.model.state = .ready
        }
        catch{
            self.model.state = .error
            self.model.state = .ready
            debugPrint(error)
        }
    }
    
    public func closeFestival() async{
        if(self.model.state == .ready){
            self.model.state = .update
            do{
                try await FestivalService.closeFestival(id: self.model.id)
                self.model.state = .closingFestival
                self.model.state = .ready
            }
            catch{
                let errorRequest = error as! RequestError
                debugPrint(errorRequest.description)
                self.model.state = .error
                self.model.state = .ready
            }
        }
    }
    
    public func changeMainFestival(oldFestival: FestivalViewModel){
        if(oldFestival.state == .ready){
            let festivalDTO: FestivalDTO = FestivalDTO(id: model.id, name: model.name, year: model.year, nbOfDays: model.nbOfDays, closed: model.closed, countBenevoles: model.numberOfBenevoles)
            oldFestival.state = .success(festivalDTO)
            oldFestival.state = .ready
        }
    }
    
    
    public func updateFestival() async{
        if(self.model.state == .ready){
            self.model.state = .update
            do{
                let festivalDTO: FestivalDTO = FestivalDTO(id: self.model.id, name: self.model.name, year: self.model.year, nbOfDays: self.model.nbOfDays, closed: self.model.closed, countBenevoles: self.model.numberOfBenevoles)
                try await FestivalService.updateFestival(festival: festivalDTO)
                self.model.state = .ready
            }
            catch{
                let errorRequest = error as! RequestError
                debugPrint(errorRequest.description)
                self.model.state = .error
                self.model.state = .ready
            }
        }
    }
            
            
    init(model: FestivalViewModel){
        self.model = model
    }
}
