//
//  Affectation.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation



class AffectationCreateDTO: Encodable, Decodable{
    var id_user: Int
    var id_zone: Int
    var id_creneau: Int
}



class AffectationViewModel: ObservableObject{
    @Published var benevole: UserViewModel
    @Published var creneau: CreneauViewModel
    @Published var zone: ZoneViewModel
    
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
    
    
}
