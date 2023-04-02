//
//  Affectation.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation



class PostAffectationDTO: Encodable, Decodable{
    var id: Int = 0
    var id_user: Int
    var id_zone: Int
    var id_creneau: Int
    
    init(idUser: Int, idZone:Int, idCreneau :Int)
    {
        self.id_user = idUser
        self.id_creneau = idCreneau
        self.id_zone = idZone
    }
}

class GetAffectationUserDTO: Decodable{
    static func decodeUser(data: [GetAffectationUserDTO]) -> [UserViewModel]?{
        var benevoles = [UserViewModel]()
        for tdata in data{
            let benevole = UserViewModel(id: tdata.id_user, firstname: tdata.firstname, lastname: tdata.lastname, email: tdata.email, password: "", role: "")
            benevoles.append(benevole)
        }
        return benevoles
    }
    
    var id: Int
    var id_user: Int
    var firstname: String
    var lastname: String
    var email: String
}

class GetAffectationCreneauDTO: Decodable{
    static func decodeData(data: [GetAffectationCreneauDTO]) -> [AffectationViewModel]?{
        var affectations = [AffectationViewModel]()
        for tdata in data{
            let creneau = CreneauViewModel(id: tdata.id_creneau, heure_debut: tdata.creneau_heure_debut, heure_fin: tdata.creneau_heure_fin, jour_name: tdata.jour_name)
            let zone = ZoneViewModel(id: tdata.id_zone, name: tdata.zone_name, number_benevoles_needed: tdata.zone_number_benevoles_needed)
            let benevole = UserViewModel()
            let affectation = AffectationViewModel(id: tdata.id,benevole: benevole, creneau: creneau, zone: zone)
            affectations.append(affectation)
        }
        return affectations
    }
    
    
    var id: Int
    var id_zone: Int
    var zone_name: String
    var zone_number_benevoles_needed: Int
    var id_creneau: Int
    var creneau_heure_debut: String
    var creneau_heure_fin: String
    var jour_name: String
    
    init(id: Int, id_zone: Int, id_creneau: Int, zone_name: String, zone_number_benevoles_needed: Int, creneau_heure_debut: String, creneau_heure_fin: String, jour_name: String){
        self.id = id
        self.id_creneau = id_creneau
        self.id_zone = id_zone
        self.zone_name = zone_name
        self.zone_number_benevoles_needed = zone_number_benevoles_needed
        self.creneau_heure_debut = creneau_heure_debut
        self.creneau_heure_fin = creneau_heure_fin
        self.jour_name = jour_name
    }
}




class AffectationViewModel: ObservableObject{
    var id: Int
    @Published var benevole: UserViewModel
    @Published var creneau: CreneauViewModel
    @Published var zone: ZoneViewModel
    
    @Published var state: AffectationState = .ready{
        didSet{
            switch state{
            case .changeZone(let zone):
                self.zone = zone
            case .changeBenevole(let benevole):
                self.benevole = benevole
            case .changeCreneau(let creneau):
                self.creneau = creneau
            default:
                break
            }
        }
    }
    
    init(id: Int,benevole: UserViewModel, creneau: CreneauViewModel, zone: ZoneViewModel){
        self.id = id
        self.benevole = benevole
        self.creneau = creneau
        self.zone = zone
    }
}


enum AffectationState: Equatable{
    case ready
    case success
    case error
    case changeBenevole(UserViewModel)
    case changeCreneau(CreneauViewModel)
    case changeZone(ZoneViewModel)
    case loading
    
    static func == (lhs: AffectationState, rhs: AffectationState) -> Bool {
        switch (lhs, rhs){
        case (.ready, .ready):
            return true
        case (.error, .error):
            return true
        case (.success, .success):
            return true
        case (.changeBenevole(_), .changeBenevole(_)):
            return true
        case (.changeCreneau(_), .changeCreneau(_)):
            return true
        case (.changeZone(_), .changeZone(_)):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    
}
