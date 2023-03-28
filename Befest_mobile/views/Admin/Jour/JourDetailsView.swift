//
//  JourDetailsView.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import SwiftUI

struct JourDetailsView: View {
    @ObservedObject var day: JourViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(day.name.uppercased())
                    .font(.headline)
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text("\(day.heure_ouverture) - \(day.heure_fermeture)")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Text("\(day.number_benevoles) bénévoles")
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    init(jour: JourViewModel){
        self.day = jour
    }
}
