//
//  EditFestivalView.swift
//  Befest_mobile
//
//  Created by m1 on 25/03/2023.


import SwiftUI


struct EditFestivalView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @State var intent: FestivalIntent?

    var body: some View {
            NavigationView{
                VStack {
                    Section(header:
                                ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.1))
                                            .frame(height: 50)
                                            .shadow(radius: 1)
                                        
                                        Text("Informations du festival")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                    }
                    ){
                        VStack(alignment: .leading) {
                            HStack() {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 50)
                                    .frame(width: 150)
                                    .shadow(radius: 1)
                                    Text("Nom du festival")
                                    .fontWeight(.bold)
                                }
                                TextField("Nom du festival", text: $festivalVM.name)
                                .padding(12)
                                .padding(.horizontal)
                                .background(
                                    Color(UIColor.systemGray6)
                                )
                                .cornerRadius(10)
                                .previewLayout(.sizeThatFits)
                                .fixedSize()
                                .shadow(radius: 2)
                            }
                            .fixedSize()
                            HStack(spacing: 6) {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 50)
                                    .frame(width:150)
                                    .shadow(radius: 1)
                                    Text("Année")
                                    .fontWeight(.bold)
                                }
                                
                                TextField("Année", text: $festivalVM.year)
                                .padding(12)
                                .padding(.horizontal)
                                .background(
                                    Color(UIColor.systemGray6)
                                )
                                .cornerRadius(10)
                                .previewLayout(.sizeThatFits)
                                .fixedSize()
                                .shadow(radius: 2)
                            }
                            .fixedSize()
                            
                            HStack(spacing:6){
                                Button(action: {
                                    // Enregistrer les changements et quitter la page d'édition
                                    Task{
                                        await self.intent!.updateFestival()
                                    }
                                }) {
                                    Text("Enregistrer")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                }
                                .padding(15)
                                .background(Color.purple)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                
                                Button(action: {
                                    Task{
                                        await self.intent!.closeFestival()
                                        debugPrint(festivalVM.closed)
                                    }
                                })
                                {
                                    Text("Clôturer")
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }
                                .padding(15)
                                .background(Color.accentColor)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                            }
                            .previewLayout(.sizeThatFits)
                            .fixedSize()
                            
                        }
                    }
                    .padding(.horizontal, 20) // Ajouter du padding horizontal
                    // Ajouter d'autres champs pour les informations du festival
                    
                    
                    Spacer()
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
            .onAppear {
                self.intent = FestivalIntent(model: festivalVM)
            }
        }
    }

