//
// AddDispoView.swift
// Befest_mobile
//
// Created by etud on 31/03/2023.
//

import SwiftUI

struct AddDispoView: View {
    // Accès à l'environnement de l'utilisateur et aux listes des créneaux, zones et jours
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listOfCreneau: ListCreneauxVM
    @ObservedObject var listOfJours: ListJoursVM

    // Intentions de la liste de créneaux, de zones et de jours
    private var intentListCreneau: CreneauListIntent
    private var intentListJours: JourListIntent


    // État des sélections de jour et de créneau
    @State var selectedJour: Int = 0
    
    @State var isLoading: Bool = false
    @State var isLoading_jour: Bool = false


    var body: some View {
        NavigationView{
                ScrollView{
                    if(isLoading_jour){
                        ProgressView()
                    }
                    // Parcours de la liste des jours
                    ForEach(listOfJours.listOfJours, id: \.id){ jour in
                        VStack{
                            HStack{
                                Spacer().frame(width:10)
                                // Affichage du nom du jour
                                Text("\(jour.name)")
                                    .bold()
                                    .font(.system(size: 22))
                                    .foregroundColor(.purple)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                // Affichage de la flèche indiquant si le jour est sélectionné ou non
                                if(selectedJour == jour.id){
                                    Button(action:{
                                        self.selectedJour = 0
                                    }){
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .foregroundColor(.gray)
                                    }
                                }
                                else{
                                    Button(action: {
                                        self.selectedJour = jour.id
                                    }){
                                        Image(systemName: "arrowtriangle.right.fill")
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer().frame(width:10)
                            }
                            .padding(10)
                            
                            // Affichage des créneaux si le jour est sélectionné
                            if(selectedJour == jour.id){
                                VStack{
                                    if(isLoading){
                                        ProgressView()
                                    }
                                    else{
                                        if(listOfCreneau.listOfCreneaux.count == 0){
                                            Text("Pas de créneaux existants")
                                        }
                                        else{
                                            // Parcours de la liste des créneaux pour le jour sélectionné
                                            ForEach(listOfCreneau.listOfCreneaux, id: \.id){
                                                creneau in
                                                CreneauDispoView(creneau: creneau)
                                            }
                                        }
                                    }
                                }
                                // Chargement de la liste des créneaux pour le
                                .onAppear(){
                                    self.intentListCreneau.getData(jour: jour.id)
                                }
                            }
                            
                            HStack{
                                Spacer().frame(width: 20)
                                Rectangle()
                                    .frame(height: 1.0, alignment: .bottom)
                                    .foregroundColor(Color.gray)
                            }
                            
                        }
                       
                    }
                }.onAppear(){
                    self.intentListJours.getData(festival: festivalVM.id)
                }
                .onChange(of: self.listOfCreneau.state){
                    newValue in
                    switch newValue{
                    case .loading:
                        self.isLoading = true
                    case .ready:
                        self.isLoading = false
                    default:
                        break
                    }
                }
                .onChange(of: self.listOfJours.state){
                    newValue in
                    switch newValue{
                    case .loading:
                        self.isLoading_jour = true
                    case .ready:
                        self.isLoading_jour = false
                    default:
                        break
                    }
                }
                .navigationBarTitle(Text("Choix des dispos"))
            }
        
    }
    
    
    init(){
        let listCreneau = ListCreneauxVM()
        let listJour = ListJoursVM()
        self.listOfCreneau = listCreneau
        self.listOfJours = listJour
        self.intentListCreneau = CreneauListIntent(listCreneauVM: listCreneau)
        self.intentListJours = JourListIntent(listJours: listJour)
    }
}
