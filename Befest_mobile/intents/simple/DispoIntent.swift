//
//  DispoIntent.swift
//  Befest_mobile
//
//  Created by etud on 30/03/2023.
//

import Foundation
import SwiftUI


struct DispoIntent{
    @ObservedObject var model: DisponibiliteViewModel

    
    
    
    init(model: DisponibiliteViewModel){
        self.model = model
    }
}
