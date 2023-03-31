//
//  Disponibilite.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation

struct PostDisponibiliteDTO: Encodable{
    var id: Int
    var user_dispo: Int
    var creneau_dispo: Int
}

struct GetDispoUserDTO: Decodable{
    static func decodeDispo(data: [GetDispoUserDTO]) -> [DisponibiliteViewModel]?{
        var dispos: [DisponibiliteViewModel] = []
        for tdata in data{
            let dispo: DisponibiliteViewModel = DisponibiliteViewModel(dispo_benevole: tdata)
            dispos.append(dispo)
        }
        return dispos
    }
    
    var id: Int
    var user_dispo: Int
    var email: String
    var firstname: String
    var lastname: String
}

struct GetDispoCreneauDTO: Decodable{
    static func decodeDispo(data: [GetDispoCreneauDTO]) -> [DisponibiliteViewModel]?{
        var dispos: [DisponibiliteViewModel] = []
        for tdata in data{
            let dispo: DisponibiliteViewModel = DisponibiliteViewModel(dispo_creneau: tdata)
            dispos.append(dispo)
        }
        return dispos
    }
    var id: Int
    var creneau_dispo: Int
    var heure_debut: String
    var heure_fin: String
    var jour: String
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
        self.creneau = CreneauViewModel(id: dispo_creneau.creneau_dispo, heure_debut: dispo_creneau.heure_debut, heure_fin: dispo_creneau.heure_fin, jour_name: dispo_creneau.jour)
    }
    
    
}


enum DispoState: Equatable{
    case ready
    case loading
    case error
    case success
    
    static func == (lhs: DispoState, rhs: DispoState) -> Bool{
        switch(rhs, lhs){
        case(.ready, .ready):
            return true
        case (.loading, .loading):
            return true
        case (.error, .error):
            return true
        case (.success, .success):
            return true
        default:
            return false
        }
    }
}
