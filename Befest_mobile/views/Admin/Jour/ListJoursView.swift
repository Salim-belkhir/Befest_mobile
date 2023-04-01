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
    @EnvironmentObject var userVM : UserViewModel
    
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText) // Recherche des jours
                List {
                    ForEach(listeOfJours.listOfJours, id: \.id) { day in // Tri par ordre alphabétique
                        NavigationLink(destination: ListCreneauxView(jour: day.id)){
                            JourDetailsView(jour: day)
                        }
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
            .navigationBarTitle("Journées")
            .onAppear(){
                if(userVM.role == "admin")
                {
                    self.intent.getData(festival: festivalVM.id)
                } else {
                    self.intent.getDataBen(festival: festivalVM.id, user : userVM.id)
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal){
                    NameFestivalNavBar()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    DisconnectNavBar()
                }
            }
        }
    }
    
    init(){
        let listOfJours = ListJoursVM()
        self.intent = JourListIntent(listJours: listOfJours)
        self.listeOfJours = listOfJours
    }
}
