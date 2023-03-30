//
//  ListDispoView.swift
//  Befest_mobile
//
//  Created by etud on 30/03/2023.
//

import SwiftUI

struct ListDispoView: View {
    private let userId: Int
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listDispos: ListDisponibilitesVM
    private var intent: DispoListIntent
    
    var body: some View {
        List{
            if(listDispos.listOfDisponibilites.isEmpty){
                Text("Malheuresement il n'existe pas de dispo pour ce festival pour ce bénévole")
            }
            ForEach(listDispos.listOfDisponibilites.sorted { ($0.creneau?.jour_name)! < ($1.creneau?.jour_name)!}, id:\.id){
                dispo in
                ItemDispoView(dispo: dispo)
                    .contentShape(Rectangle())
                    .padding(10)
            }
        }
        .onAppear(){
            self.intent.getDataUser(user: userId, festival: festivalVM.id)
        }
    }
    
    
    init(user: Int){
        self.userId = user
        let list = ListDisponibilitesVM()
        self.listDispos = list
        self.intent = DispoListIntent(listOfDispos: list)
    }
}
