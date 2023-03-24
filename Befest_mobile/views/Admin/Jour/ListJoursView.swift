//
//  ListJoursView.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import SwiftUI


/*
struct ListJoursView: View {

    @State var days: [JourViewModel] = [] // Données de jours à afficher dans la liste

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText) // Recherche des jours
                List {
                    ForEach(days.sorted(by: { $0.name < $1.name })) { day in // Tri par ordre alphabétique
                        NavigationLink(destination: DayDetailView(day: day)) { // Navigation vers la vue détail
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(day.name.uppercased())
                                        .font(.headline)
                                    HStack {
                                        Image(systemName: "clock")
                                            .foregroundColor(.gray)
                                        Text("\(day.openingHour) - \(day.closingHour)")
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Text("\(day.volunteersCount)")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: delete) // Suppression d'un jour
                }
            }
            .navigationBarTitle("Festivals") // Titre de la barre de navigation
        }
    }

    private func delete(at offsets: IndexSet) {
        days.remove(atOffsets: offsets) // Suppression du jour sélectionné
    }
}*/
