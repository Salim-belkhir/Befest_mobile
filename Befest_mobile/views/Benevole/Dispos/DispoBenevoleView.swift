//
// ListDisposView.swift
// Befest_mobile
//
// Created by etud on 27/03/2023.
//

import SwiftUI

struct DispoBenevoleView: View {
    // Accès à l'environnement de l'utilisateur
    @EnvironmentObject var userMV: UserViewModel
    // Accès à l'environnement du festival
    @EnvironmentObject var festivalVM: FestivalViewModel
    // Objet observé qui contient la liste des disponibilités du bénévole
    @ObservedObject var listDisposVM: ListDisponibilitesVM
    // Intent pour interagir avec la liste des disponibilités
    private var intentListDispos: DispoListIntent

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer().frame(width:10)
                    // Titre de la liste des festivals avec bouton pour ajouter une disponibilité
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
                Text("Boutton ajouter à mettre là") // TODO: À compléter avec le bouton d'ajout de festival
                
                Text("Liste des dispos") // Titre de la liste des disponibilités du bénévole
                
                List{
                    ForEach(listDisposVM.listOfDisponibilites, id: \.id){
                        dispo in
                        VStack{
                            Text(dispo.creneau?.jour_name ?? "Pas de nom") // Jour de la disponibilité
                            Text(dispo.creneau?.heure_debut ?? "Pas de heure de debut") // Heure de début de la disponibilité
                        }
                    }
                    .onDelete{ // Bouton de suppression d'une disponibilité
                        indexSet in
                        self.intentListDispos.delete(at: indexSet)
                    }
                    .onMove{ // Bouton de déplacement d'une disponibilité
                        indexSet, index in
                        self.intentListDispos.move(fromOffsets: indexSet, toOffset: index)
                    }
                    
                    EditButton() // Bouton d'édition de la liste des disponibilités
                }
            }
            .onAppear(){ // Chargement des données de l'utilisateur au démarrage de la vue
                self.intentListDispos.getDataUser(user: userMV.id, festival: festivalVM.id)
            }
            .toolbar{ // Barre d'outils en haut de la vue
                ToolbarItem(placement: .principal){
                    NameFestivalNavBar() // Affichage du nom du festival en haut de la barre d'outils
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    DisconnectNavBar() // Bouton de déconnexion en haut à droite de la barre d'outils
                }
            }
        }
    }

    // Initialisation de la vue
    init(){
        let listDispos = ListDisponibilitesVM() // Création d'un objet ListDisponibilitesVM
        self.listDisposVM = listDispos // Initialisation de l'objet observé avec la liste de disponibilités
        self.intentListDispos = DispoListIntent(listOfDispos: listDispos)
    }
}
