//
// ListCreneauxView.swift
// Befest_mobile
//
// Created by etud on 29/03/2023.
//

import SwiftUI

struct ListCreneauxView: View {
    private var idJour: Int // identifiant du jour
    @ObservedObject var listCreneaux: ListCreneauxVM // vue modèle pour la liste des créneaux
    private var intent: CreneauListIntent // intention pour la liste des créneaux
    @EnvironmentObject var userVM : UserViewModel // vue modèle pour l'utilisateur


    var body: some View{
        NavigationView(){ // affichage d'une vue de navigation
            VStack{ // alignement vertical
                Section(header: Text("Créneaux")){ // section pour la liste des créneaux
                    List{ // affichage de la liste des créneaux
                        ForEach(listCreneaux.listOfCreneaux, id: \.id){ // pour chaque créneau dans la liste
                            creneau in
                            ItemCreneauView(creneau: creneau) // affichage d'une vue d'un créneau
                        }
                    }
                }
                .navigationTitle(Text("Créneaux existants")) // titre de la vue
            }
            .task { // tâche asynchrone lors du chargement de la vue
                if(userVM.role == "admin") // si l'utilisateur est un administrateur
                {
                    self.intent.getData(jour: idJour) // récupération des données pour tous les utilisateurs
                } else { // sinon
                    self.intent.getDataBen(jour: idJour, user : userVM.id) // récupération des données pour un utilisateur spécifique
                }
            }
        }
    }

    init(jour: Int){ // initialisation de la vue avec l'identifiant du jour en paramètre
        self.idJour = jour
        let listCreneaux = ListCreneauxVM() // création d'une vue modèle pour la liste des créneaux
        self.listCreneaux = listCreneaux
        self.intent = CreneauListIntent(listCreneauVM: listCreneaux) // création de l'intention pour la liste des créneaux
    }
}



