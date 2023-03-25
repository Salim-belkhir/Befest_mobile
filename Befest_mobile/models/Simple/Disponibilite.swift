//
//  Disponibilite.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation

struct PostDisponibiliteDTO: Encodable{
    var user_dispo: Int
    var creneau_dispo: Int
}

struct GetDispoUserDTO: Decodable{
    var id: Int
    var user_dispo: Int
    var email: String
    var firstname: String
    var lastname: String
}

struct GetDispoCreneauDTO: Encodable{
    var id: Int
    var creneau_dispo: Int
    var heureDebut: Date
    var heureFin: Date
}

class DisponibiliteViewModel: ObservableObject{
    var id: Int
    @Published var benevole: UserViewModel?
    @Published var creneau: CreneauViewModel?
    @Published var state: DispoState = .ready {
        didSet{
            switch state {
            default:
                break
            }
        }
    }
    
    
    init(dispo_benevole: GetDispoUserDTO){
        self.id = dispo_benevole.id
        self.benevole = UserViewModel(id: dispo_benevole.user_dispo, firstname: dispo_benevole.firstname, lastname: dispo_benevole.lastname, email: dispo_benevole.email, password: "", role: "")
    }
    
    init(dispo_creneau: GetDispoCreneauDTO){
        self.id = dispo_creneau.id
        self.creneau = CreneauViewModel(id: dispo_creneau.creneau_dispo, heure_debut: dispo_creneau.heureDebut, heure_fin: dispo_creneau.heureFin)
    }
    
    
}


enum DispoState: Equatable{
    case ready
    case loading
    case error
    
    static func == (lhs: DispoState, rhs: DispoState) -> Bool{
        switch(rhs, lhs){
        case(.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
