//
// CreneauxZoneView.swift
// Befest_mobile
//
// Created by etud on 31/03/2023.
//

import SwiftUI

struct CreneauxZoneView: View {
    // ID du créneau à afficher
    private var idCreneau: Int
    // La zone correspondante à la vue
    @ObservedObject var zoneVM: ZoneViewModel

    // La liste des bénévoles affectés à la zone pour le créneau donné
    @ObservedObject var listBenevoles: BenevolesListVM

    // L'objet intent qui permet d'obtenir les données des bénévoles affectés à la zone pour le créneau donné
    private var intentlistBenevoles: UserListIntent

    // Etat de l'affichage des bénévoles
    @State private var showBenevoles: Bool = false


    var body: some View {
        VStack{
            // En-tête de la vue
            HStack{
                Spacer().frame(width: 10)
                Text("\(zoneVM.name)")
                    .padding(10)
                
                Spacer()
                
                // Bouton pour afficher/masquer la liste des bénévoles affectés à la zone pour le créneau donné
                if(!showBenevoles){
                    Button(action:{
                        self.showBenevoles = true
                    })
                    {
                        Image(systemName: "arrowtriangle.right.fill")
                            .foregroundColor(.gray)
                    }
                }
                else{
                    Button(action: {
                        self.showBenevoles = false
                    })
                    {
                        Image(systemName: "arrowtriangle.up.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // Liste des bénévoles affectés à la zone pour le créneau donné
            if(showBenevoles){
                ScrollView{
                    // Affiche une barre de progression pendant le chargement des données
                    if(listBenevoles.state == .loading){
                        ProgressView()
                    }
                    else{
                        // Affiche un message s'il n'y a pas de bénévoles affectés à la zone pour le créneau donné
                        if(listBenevoles.listOfBenevoles.count == 0){
                            Text("Pas d'affectations existantes")
                        }
                        else{
                            // Affiche les bénévoles affectés à la zone pour le créneau donné
                            ForEach(listBenevoles.listOfBenevoles, id: \.id){ benevole in
                                BenevoleItemView(benevole: benevole)
                            }
                        }
                    }
                }
                // Récupère les données des bénévoles affectés à la zone pour le créneau donné lorsqu'on affiche la liste des bénévoles
                .onAppear(){
                    self.intentlistBenevoles.getDataForCreneauForZone(zone: self.zoneVM.id, creneau: idCreneau)
                }
            }
            
        }
    }

    // Initialise la vue avec la zone et l'ID de créneau correspondants
    init(zone: ZoneViewModel, idCreneau: Int){
        self.zoneVM = zone
        
        // Initialise la liste des bénévoles affectés à la zone pour le créneau donné
        let listBenevoles = BenevolesListVM()
        self.listBenevoles = listBenevoles
        self.intentlistBenevoles = UserListIntent(listBenevoles: listBenevoles)
        self.idCreneau = idCreneau
    }
}
