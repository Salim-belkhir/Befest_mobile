//
//  Creneau.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation


struct GetCreneauDTO: Decodable, Encodable{
    var id: Int
    var heureDebut: Date
    var heureFin: Date
}


struct PostCreneauDTO: Encodable{
    var heureDebut: Date
    var heureFin: Date
    var jour_creneau: Int
}


class CreneauViewModel: ObservableObject{
    public var id: Int
    @Published var heure_debut: Date
    @Published var heure_fin: Date
    @Published var state: CreneauState = .ready {
        didSet{
            switch state{
            case .changeHeureDebut(let heure):
                self.heure_debut = heure
            case .changeHeureFin(let heure):
                self.heure_fin = heure
            default:
                break
            }
        }
    }
    
    init(id: Int, heure_debut: Date, heure_fin: Date){
        self.id = id
        self.heure_debut = heure_debut
        self.heure_fin = heure_fin
    }
}



enum CreneauState: Equatable{
    case ready
    case creneau
    case changeHeureDebut(Date)
    case changeHeureFin(Date)
    
    
    
}
