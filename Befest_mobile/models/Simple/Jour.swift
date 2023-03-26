//
//  Jour.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation
import SwiftUI
import CloudKit


struct GetJourDTO: Encodable, Decodable{
    static func decodeJour(data: [GetJourDTO]) -> [JourViewModel]?{
        var jours = [JourViewModel]()
        for tdata in data{
            guard(tdata.id != 0) else{
                return nil
            }
            let jour = JourViewModel(id: tdata.id, name: tdata.name, heure_ouverture: tdata.heureOuverture, heure_fermeture: tdata.heureFermeture, number_benevoles: tdata.countBenevoles)
            jours.append(jour)
        }
        return jours
    }
    
    
    var id: Int
    var name: String
    var heureOuverture: Date
    var heureFermeture: Date
    var countBenevoles: Int
}

struct PostJourDTO: Encodable{
    var id: Int
    var name: String
    var heureOuverture: Date
    var heureFermeture: Date
    var festival_jour: Int
}



class JourViewModel: ObservableObject{
    public var id: Int
    @Published var name: String
    @Published var heure_ouverture: Date
    @Published var heure_fermeture: Date
    @Published var number_benevoles: Int
    @Published var state: JourState = .ready {
        didSet{
            switch state{
            case .changeName(let newName):
                self.name = newName
            case .changeHeureFermeture(let heure):
                self.heure_fermeture = heure
            case .changeHeureOuverture(let heure):
                self.heure_ouverture = heure
            default:
                break
            }
        }
    }
    
    init(id: Int, name: String, heure_ouverture: Date, heure_fermeture: Date, number_benevoles: Int){
        self.id = id
        self.name = name
        self.heure_ouverture = heure_ouverture
        self.heure_fermeture = heure_fermeture
        self.number_benevoles = number_benevoles
    }
}



enum JourState: Equatable{
    case ready
    case error
    case success(JourViewModel)
    case changeName(String)
    case changeHeureOuverture(Date)
    case changeHeureFermeture(Date)
    case loading
    
    
    static func == (lhs: JourState, rhs: JourState) -> Bool {
        switch (lhs, rhs){
        case (.ready, .ready):
            return true
        case (.error, .error):
            return true
        case (.success(_), .success(_)):
            return true
        case (.changeName(_), .changeName(_)):
            return true
        case (.changeHeureOuverture(_), .changeHeureOuverture(_)):
            return true
        case (.changeHeureFermeture(_), .changeHeureFermeture(_)):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    
}
