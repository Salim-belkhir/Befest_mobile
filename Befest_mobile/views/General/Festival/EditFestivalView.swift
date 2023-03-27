//
//  EditFestivalView.swift
//  Befest_mobile
//
//  Created by m1 on 25/03/2023.
//

import SwiftUI


struct EditFestivalView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @State var intent: FestivalIntent?

    @State private var isEditing = false

    var body: some View {
        NavigationView{
            VStack {
                Section(header: Text("Formulaire")){
                    HStack {
                        Text("Nom du festival :")
                        if isEditing {
                            TextField("Nom du festival", text: $festivalVM.name)
                                .frame(width: 50)
                        } else {
                            Text(festivalVM.name)
                                .frame(width: 50)
                                .onTapGesture {
                                    isEditing = true
                                }
                        }
                    }
                    
                    HStack {
                        Text("Année :")
                        if isEditing {
                            TextField("Année", text: $festivalVM.year)
                        } else {
                            Text(festivalVM.year)
                                .onTapGesture {
                                    isEditing = true
                                }
                        }
                    }
                }
                
                // Ajouter d'autres champs pour les informations du festival
                
                HStack{
                    
                    Button(action: {
                        // Enregistrer les changements et quitter la page d'édition
                        Task{
                            await self.intent!.updateFestival()
                        }
                    }) {
                        Text("Enregistrer")
                            .foregroundColor(.white)
                    }
                    .padding(8)
                    .background(Color.purple)
                    .cornerRadius(10)
                    Button(action: {
                        Task{
                            await self.intent!.closeFestival()
                            debugPrint(festivalVM.closed)
                        }
                    })
                    {
                        Text("Clôturer")
                            .foregroundColor(.white)
                    }
                    .padding(8)
                    .background(Color.purple)
                    .cornerRadius(10)
                    
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
            .navigationTitle(Text("Informations"))
        
        }
        .onAppear {
            self.intent = FestivalIntent(model: festivalVM)
        }
    }
        
    
}

