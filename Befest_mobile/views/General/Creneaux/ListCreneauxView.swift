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
    @EnvironmentObject var userVM : UserViewModel

    
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
                if(userVM.role == "admin")
                {
                    self.intent.getData(jour: idJour)
                } else {
                    await self.intent.getDataBen(jour: idJour, user : userVM.id)
                }
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


