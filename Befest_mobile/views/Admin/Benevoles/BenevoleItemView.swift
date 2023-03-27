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
        VStack{
            Text("\(benevole.lastname) \(benevole.firstname)")
                .font(.system(size: 15))
            Text(benevole.email)
                .foregroundColor(.blue)
                .font(.system(size: 11))
        }
    }
    
    init(benevole: UserViewModel) {
        self.benevole = benevole
    }
}
