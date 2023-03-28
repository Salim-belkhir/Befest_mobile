//
//  Zone.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation


struct ZoneDTO: Decodable, Encodable{
    static func decodeZone(data: [ZoneDTO]) -> [ZoneViewModel]?{
        var zones = [ZoneViewModel]()
        for tdata in data{
            guard(tdata.id != 0) else{
                return nil
            }
            let zone = ZoneViewModel(id: tdata.id, name: tdata.name, number_benevoles_needed: tdata.nbBenevolesNeeded)
            zones.append(zone)
        }
        return zones
    }
    
    var id: Int
    var name: String
    var nbBenevolesNeeded: Int
    var festival_zone: Int
   
    init(id: Int, name: String, nbBenevolesNeeded: Int, festival_zone: Int){
        self.id = id
        self.name = name
        self.nbBenevolesNeeded = nbBenevolesNeeded
        self.festival_zone = festival_zone
    }
}


class ZoneViewModel: ObservableObject{
    public var id: Int
    @Published var name: String
    @Published var number_benevoles_needed: Int
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



enum ZoneState: Equatable{
    case ready
    case loading
    case error
    case changeName(String)
    case changeNbBenevolesNeeded(Int)
    case success
    
    static func == (lhs: ZoneState, rhs: ZoneState) -> Bool {
        switch (lhs, rhs){
        case (.ready, .ready):
            return true
        case (.error, .error):
            return true
        case (.success, .success):
            return true
        case (.changeName(_), .changeName(_)):
            return true
        case (.changeNbBenevolesNeeded(_), .changeNbBenevolesNeeded(_)):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
}
