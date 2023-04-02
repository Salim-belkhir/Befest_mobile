//
// AddDispoView.swift
// Befest_mobile
//
// Created by etud on 31/03/2023.
//

import SwiftUI

struct AddDispoView: View {
    // Accès à l'environnement de l'utilisateur et aux listes des créneaux, zones et jours
    @EnvironmentObject var userVM: UserViewModel
    @ObservedObject var listOfCreneau: ListCreneauxVM
    @ObservedObject var listOfZones: ListZoneVM
    @ObservedObject var listOfJours: ListJoursVM

    // Intention d'une disponibilité à ajouter
    private var intentDispo: DispoIntent = DispoIntent(model: DisponibiliteViewModel(dispo_creneau: GetDispoCreneauDTO(id: 0, creneau_dispo: 0, heure_debut: "", heure_fin: "", jour: "")))

    // Intentions de la liste de créneaux, de zones et de jours
    private var intentListCreneau: CreneauListIntent
    private var intentListZones: ZoneListIntent
    private var intentListJours: JourListIntent


    // État des sélections de jour et de créneau
    @State var selectedJour: Int = 0
    @State var selectedCreneau: Int = 0


    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    // Parcours de la liste des jours
                    ForEach(listOfJours.listOfJours, id: \.id){ jour in
                        VStack{
                            // Affichage du nom du jour
                            Text("\(jour.name)")
                                .bold()
                                .font(.system(size: 20))
                            
                            Spacer()
                            
                            // Affichage de la flèche indiquant si le jour est sélectionné ou non
                            if(selectedJour == jour.id){
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundColor(.gray)
                            }
                            else{
                                Button(action: {
                                    self.selectedJour = jour.id
                                }){
                                    Image(systemName: "arrowtriangle.right.fill")
                                }
                            }
                            
                            // Affichage des créneaux si le jour est sélectionné
                            if(selectedJour == jour.id){
                                VStack{
                                    // Parcours de la liste des créneaux pour le jour sélectionné
                                    ForEach(listOfCreneau.listOfCreneaux, id: \.id){
                                        creneau in
                                        VStack{
                                            HStack{
                                                // Affichage de l'heure de début et de fin du créneau
                                                Text("\(creneau.heure_debut)-\(creneau.heure_fin)")
                                                
                                                // Bouton permettant de choisir le créneau pour ajouter la disponibilité
                                                Button("Choisir"){
                                                    let dispoDTO = PostDisponibiliteDTO(id: 0, user_dispo: userVM.id, creneau_dispo: creneau.id)
                                                    self.intentDispo.createDispo(dispo: dispoDTO)
                                                }
                                                
                                                // Affichage de la flèche indiquant si le créneau est sélectionné ou non
                                                if(selectedCreneau == creneau.id){
                                                    Image(systemName: "arrowtriangle.up.fill")
                                                        .foregroundColor(.gray)
                                                }
                                                else{
                                                    Button(action: {
                                                        self.selectedJour = jour.id
                                                    }){
                                                        Image(systemName: "arrowtriangle.right.fill")
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                // Chargement de la liste des créneaux pour le
                                .onAppear(){
                                    self.intentListCreneau.getData(jour: jour.id)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    init(){
        let listCreneau = ListCreneauxVM()
        let listZone = ListZoneVM()
        let listJour = ListJoursVM()
        self.listOfZones = listZone
        self.listOfCreneau = listCreneau
        self.listOfJours = listJour
        self.intentListZones = ZoneListIntent(listOfZones: listZone)
        self.intentListCreneau = CreneauListIntent(listCreneauVM: listCreneau)
        self.intentListJours = JourListIntent(listJours: listJour)
    }
}
