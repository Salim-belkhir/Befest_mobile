//
//  Creneau.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation


struct GetCreneauDTO: Decodable, Encodable{
    static func decodeCreneau(data: [GetCreneauDTO]) -> [CreneauViewModel]?{
        var creneaux: [CreneauViewModel] = []
        for tdata in data{
            let creneau : CreneauViewModel = CreneauViewModel(id: tdata.id, heure_debut: tdata.heureDebut, heure_fin: tdata.heureFin)
            creneaux.append(creneau)
        }
        return creneaux
    }
    
    var id: Int
    var heureDebut: String
    var heureFin: String
}


struct PostCreneauDTO: Encodable{
    var id: Int
    var heureDebut: String
    var heureFin: String
    var jour_creneau: Int
}


class CreneauViewModel: ObservableObject{
    public var id: Int
    @Published var heure_debut: String
    @Published var heure_fin: String
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
    
    init(id: Int, heure_debut: String, heure_fin: String){
        self.id = id
        self.heure_debut = heure_debut
        self.heure_fin = heure_fin
    }
}



enum CreneauState: Equatable{
    case ready
    case creneau
    case changeHeureDebut(String)
    case changeHeureFin(String)
    
    
    
}
