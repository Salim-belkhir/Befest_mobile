//
//  ItemAffectationView.swift
//  Befest_mobile
//
//  Created by etud on 31/03/2023.
//

import SwiftUI

struct ItemAffectationView: View {
    @ObservedObject var affectation: AffectationViewModel
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(.purple)
                Text(affectation.creneau.jour_name ?? "Nom pas trouvé")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.purple)
                Text(affectation.zone.name)
                    .font(.system(size: 14))
            }
            Spacer().frame(height: 10)
            HStack{
                Spacer().frame(width: 10)
                Image(systemName: "clock.fill")
                Text("\(affectation.creneau.heure_debut)-\(affectation.creneau.heure_fin)")
                Spacer()
            }
            .foregroundColor(.gray)
        }
    }
    
    init(affectation: AffectationViewModel){
        self.affectation = affectation
    }
}

