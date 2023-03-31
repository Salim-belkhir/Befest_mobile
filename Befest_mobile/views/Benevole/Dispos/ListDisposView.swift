//
//  ListDisposView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct ListDisposView: View {
    @EnvironmentObject var userMV: UserViewModel
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listDisposVM: ListDisponibilitesVM
    private var intentListDispos: DispoListIntent
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Boutton ajouter à mettre là")
                
                Text("Liste des dispos")
                
                ScrollView{
                    ForEach(listDisposVM.listOfDisponibilites, id: \.id){
                        dispo in
                        Text(dispo.creneau?.jour_name ?? "Pas de nom")
                        Text(dispo.creneau?.heure_debut ?? "Pas de heure de debut")
                    }
                }
            }
            .onAppear(){
                self.intentListDispos.getDataUser(user: userMV.id, festival: festivalVM.id)
            }
        }
    }
    
    
    init(){
        let listDispos = ListDisponibilitesVM()
        self.listDisposVM = listDispos
        self.intentListDispos = DispoListIntent(listOfDispos: listDispos)
    }
}
