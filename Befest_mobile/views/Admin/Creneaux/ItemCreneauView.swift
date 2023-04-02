//
// ItemCreneauView.swift
// Befest_mobile
//
// Created by etud on 29/03/2023.
//

import SwiftUI

struct ItemCreneauView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel // vue modèle pour le festival
    @ObservedObject var creneau: CreneauViewModel // vue modèle pour le créneau
    @ObservedObject var zoneList: ListZoneVM    // vue modèle pour la liste des zones
    private var zoneListIntent: ZoneListIntent // intention pour la liste des zones
    @State var showZones: Bool = false  // booléen pour afficher ou non les zones du créneau

    var body: some View {
        VStack{
            //Affiche l'heure de début et de fin du créneau
            HStack{
                Text("Creneau \(creneau.heure_debut)-\(creneau.heure_fin)")
                    .padding(10)
                Spacer()
                //Bouton pour afficher les zones du créneau
                if(!showZones){
                    Button(action:{
                        self.showZones = true
                    })
                    {
                        Image(systemName: "arrowtriangle.right.fill")
                    }
                }
                //Bouton pour cacher les zones du créneau
                else{
                    Button(action: {
                        self.showZones = false
                    })
                    {
                        Image(systemName: "arrowtriangle.up.fill")
                    }
                
                }
            }
            
            //Affiche la liste des zones pour le créneau courant
            if(showZones){
                ScrollView{
                    ForEach(zoneList.listOfZones, id: \.id){ zone in
                        CreneauxZoneView(zone: zone, idCreneau: self.creneau.id)
                    }
                }
                //Charge les zones associées au festival courant lors de l'apparition de la vue
                .onAppear(){
                    self.zoneListIntent.getData(festival: festivalVM.id)
                }
            }
            
        }
    }

    //Initialise la vue avec le créneau passé en paramètre
    init(creneau: CreneauViewModel) {
        self.creneau = creneau
        let listOfZones = ListZoneVM()
        self.zoneList = listOfZones
        self.zoneListIntent = ZoneListIntent(listOfZones: listOfZones)
    }
}
