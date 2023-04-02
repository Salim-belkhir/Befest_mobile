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
                    Spacer()
                    // Titre de la liste des festivals avec bouton pour ajouter une disponibilité
                    NavigationLink(destination: AddDispoView()){
                        Image(systemName: "plus")
                            .font(.system(size:30))
                    }
                    
                    Spacer().frame(width:20)
                }
                
                List{
                    ForEach(listDisposVM.listOfDisponibilites, id: \.id){
                        dispo in
                        DispoItemView(disponibiliteVM: dispo)
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
            .navigationTitle(Text("Mes disponibilités"))
        }
    }

    // Initialisation de la vue
    init(){
        let listDispos = ListDisponibilitesVM() // Création d'un objet ListDisponibilitesVM
        self.listDisposVM = listDispos // Initialisation de l'objet observé avec la liste de disponibilités
        self.intentListDispos = DispoListIntent(listOfDispos: listDispos)
    }
}
