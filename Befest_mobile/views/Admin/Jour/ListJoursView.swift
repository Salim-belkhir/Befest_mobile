//
//  ListJoursView.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import SwiftUI



struct ListJoursView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listeOfJours: ListJoursVM
    private var intent: JourListIntent
    @State var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText) // Recherche des jours
                List {
                    ForEach(listeOfJours.listOfJours.sorted(by: { $0.name < $1.name }), id: \.id) { day in // Tri par ordre alphabétique
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
                                Text("\(day.number_benevoles)")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                    }
                    .onDelete {
                        indexSet in
                        Task{
                            await self.intent.delete(at: indexSet)
                        }
                    }
                    .onMove{
                        indexSet, index in
                        self.intent.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
            }
            .navigationBarTitle("Festivals") // Titre de la barre de navigation
            .task{
                await self.intent.getData(festival: festivalVM.id)
            }
        }
    }
    
    init(){
        let listOfJours = ListJoursVM()
        self.intent = JourListIntent(listJours: listOfJours)
        self.listeOfJours = listOfJours
    }

    
}
