//
//  ListCreneauxView.swift
//  Befest_mobile
//
//  Created by etud on 29/03/2023.
//

import SwiftUI

struct ListCreneauxView: View {
    private var idJour: Int
    @ObservedObject var listCreneaux: ListCreneauxVM
    private var intent: CreneauListIntent
    
    var body: some View{
        NavigationView(){
            VStack{
                Section(header: Text("Créneaux")){
                    List{
                        ForEach(listCreneaux.listOfCreneaux, id: \.id){
                            creneau in
                            ItemCreneauView(creneau: creneau)
                        }
                    }
                }
                .navigationTitle(Text("Créneaux existants"))
            }
            .task {
                await self.intent.getData(jour: idJour)
            }
        }
    }
    
    
    init(jour: Int){
        self.idJour = jour
        let listCreneaux = ListCreneauxVM()
        self.listCreneaux = listCreneaux
        self.intent = CreneauListIntent(listCreneauVM: listCreneaux)
    }
}


