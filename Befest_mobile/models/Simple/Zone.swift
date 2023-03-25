//
//  Zone.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation


struct ZoneDTO: Decodable, Encodable{
    var id: Int
    var name: String
    var nbBenevolesNeeded: Int
   
    init(id: Int, name: String, nbBenevolesNeeded: Int){
        self.id = id
        self.name = name
        self.nbBenevolesNeeded = nbBenevolesNeeded
    }
}


class ZoneViewModel: ObservableObject{
    var id: Int
    var name: String
    var number_benevoles_needed: Int
    var observers: [ZoneVMObserver] = []
    @Published var state: ZoneState = .ready {
        didSet{
            switch state{
            case .changeName(let newName):
                self.name = newName
                notifyAll()
            case .changeNbBenevolesNeeded(let nb):
                self.number_benevoles_needed = nb
                notifyAll()
            default:
                break
            }
        }
    }
    
    init(id: Int, name: String, number_benevoles_needed: Int){
        self.id = id
        self.name = name
        self.number_benevoles_needed = number_benevoles_needed
    }
    
    
    public func notifyAll(){
        for o in self.observers{
            o.updated(id: self.id, model: self)
        }
    }
}



enum ZoneState{
    case ready
    case loading
    case error
    case changeName(String)
    case changeNbBenevolesNeeded(Int)
}