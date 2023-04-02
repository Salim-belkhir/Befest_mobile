//
//  CreneauDispoView.swift
//  Befest_mobile
//
//  Created by m1 on 02/04/2023.
//

import SwiftUI

struct CreneauDispoView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @EnvironmentObject var userVM: UserViewModel
    @ObservedObject var creneau: CreneauViewModel
    @ObservedObject var listOfZones: ListZoneVM
    @State var showZones: Bool = false
    private var intentDispo: DispoIntent = DispoIntent(model: DisponibiliteViewModel(dispo_creneau: GetDispoCreneauDTO(id: 0, creneau_dispo: 0, heure_debut: "", heure_fin: "", jour: "")))
    private var intentListZones: ZoneListIntent
    
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Spacer().frame(width:20)
                    // Affichage de l'heure de début et de fin du créneau
                    Text("\(creneau.heure_debut)-\(creneau.heure_fin)")
                    
                    Spacer()
                    
                    // Bouton permettant de choisir le créneau pour ajouter la disponibilité
                    Button("Choisir"){
                        let dispoDTO = PostDisponibiliteDTO(id: 0, user_dispo: userVM.id, creneau_dispo: creneau.id)
                        self.intentDispo.createDispo(dispo: dispoDTO)
                    }
                        .foregroundColor(.white)
                        .padding(7)
                        .background(.purple)
                        .cornerRadius(10)
                        
                    
                    Spacer().frame(width:20)
                    
                    // Affichage de la flèche indiquant si le créneau est sélectionné ou non
                    if(showZones){
                        Button(action: {
                            self.showZones = false
                        }){
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    else{
                        Button(action: {
                            self.showZones = true
                        }){
                            Image(systemName: "arrowtriangle.right.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer().frame(width:10)

                }.padding(10)
                
                if(showZones){
                    VStack{
                        ForEach(listOfZones.listOfZones, id:\.id){
                            zone in
                            HStack{
                                Spacer().frame(width:50)
                                VStack(alignment: .leading){
                                    Text(zone.name)
                                        .font(.system(size: 20))
                                    Text("Nombre de bénévoles nécessaires: \(zone.number_benevoles_needed)")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button("S'affecter"){
                                    self.intentDispo.createAffectation(idUser: userVM.id, idZone: zone.id, idCreneau: creneau.id)
                                }
                                .foregroundColor(.white)
                                .padding(7)
                                .background(.blue)
                                .cornerRadius(10)
                                
                                Spacer().frame(width: 10)
                            }
                            .padding(10)
                        }
                    }
                }
            }
        }
        .onAppear(){
            self.intentListZones.getData(festival: festivalVM.id)
        }
    }
    
    init(creneau: CreneauViewModel){
        self.creneau = creneau
        let listOfZones = ListZoneVM()
        self.listOfZones = listOfZones
        self.intentListZones = ZoneListIntent(listOfZones: listOfZones)
    }
}
