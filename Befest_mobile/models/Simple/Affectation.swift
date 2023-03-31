//
//  Affectation.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation



class PostAffectationDTO: Encodable, Decodable{
    var id_user: Int
    var id_zone: Int
    var id_creneau: Int
    
    
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




class AffectationViewModel: ObservableObject{
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
    
    init(benevole: UserViewModel, creneau: CreneauViewModel, zone: ZoneViewModel){
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
