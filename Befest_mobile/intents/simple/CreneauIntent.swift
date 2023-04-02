//
//  CreneauIntent.swift
//  Befest_mobile
//
//  Created by m1 on 02/04/2023.
//

import Foundation
import SwiftUI



struct CreneauIntent{
    @ObservedObject var model: CreneauViewModel
    
    func changeHeureDebut(heure: String){
        self.model.state = .changeHeureDebut(heure)
        self.model.state = .ready
    }
    
    
    func changeHeureFin(heure: String){
        self.model.state = .changeHeureFin(heure)
        self.model.state = .ready
    }
    
    
    init(creneau: CreneauViewModel){
        self.model = creneau
    }
}
