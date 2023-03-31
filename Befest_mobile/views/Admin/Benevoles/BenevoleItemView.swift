//
//  BenevoleItemView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct BenevoleItemView: View {
    @ObservedObject var benevole: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(benevole.firstname) \(benevole.lastname)")
                .font(.system(size: 19))
            Text(benevole.email)
                .foregroundColor(.blue)
                .font(.system(size: 15))
        }
    }
    
    init(benevole: UserViewModel) {
        self.benevole = benevole
    }
}
