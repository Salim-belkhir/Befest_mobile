//
//  BenevoleDetailView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct BenevoleDetailView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listDispos:  ListDisponibilitesVM
    private var listIntent: DispoListIntent
    @ObservedObject var benevole: UserViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text(benevole.lastname)
                
                Text(benevole.firstname)
                
                Text("Ses disponibilites")
                    .font(.system(size: 20))
                
                List{
                    if(listDispos.listOfDisponibilites.count == 0){
                        Text("Malheuresement il n'existe pas de dispo pour ce festival pour ce bénévole")
                    }
                    ForEach(listDispos.listOfDisponibilites, id: \.id){
                        dispo in
                        ItemCreneauView(creneau: dispo.creneau!)
                    }
                }
                
                
            }
            .task {
                await self.listIntent.getDataUser(user: benevole.id, festival: festivalVM.id)
            }
            .navigationTitle("Détails")
        }
        
    }
    
    
    init(benevole : UserViewModel){
        self.benevole = benevole
        let listDispos = ListDisponibilitesVM()
        self.listDispos = listDispos
        self.listIntent = DispoListIntent(listOfDispos: listDispos)
    }
}

