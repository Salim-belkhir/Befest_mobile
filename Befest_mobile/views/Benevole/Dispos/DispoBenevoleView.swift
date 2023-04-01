//
//  ListDisposView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct DispoBenevoleView: View {
    @EnvironmentObject var userMV: UserViewModel
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listDisposVM: ListDisponibilitesVM
    private var intentListDispos: DispoListIntent
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer().frame(width:10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 40)
                            .shadow(radius: 1)
                        HStack{
                            Text("Liste des festivals")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            NavigationLink(destination: AddDispoView()){
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size:30))
                            }
                        }

                    }
                    
                    Spacer().frame(width:10)
                }
                Text("Boutton ajouter à mettre là")
                
                Text("Liste des dispos")
                
                List{
                    ForEach(listDisposVM.listOfDisponibilites, id: \.id){
                        dispo in
                        VStack{
                            Text(dispo.creneau?.jour_name ?? "Pas de nom")
                            Text(dispo.creneau?.heure_debut ?? "Pas de heure de debut")
                        }
                    }
                    .onDelete{
                        indexSet in
                        self.intentListDispos.delete(at: indexSet)
                    }
                    .onMove{
                        indexSet, index in
                        self.intentListDispos.move(fromOffsets: indexSet, toOffset: index)
                    }
                    
                    EditButton()
                }
            }
            .onAppear(){
                self.intentListDispos.getDataUser(user: userMV.id, festival: festivalVM.id)
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
        let listDispos = ListDisponibilitesVM()
        self.listDisposVM = listDispos
        self.intentListDispos = DispoListIntent(listOfDispos: listDispos)
    }
}
