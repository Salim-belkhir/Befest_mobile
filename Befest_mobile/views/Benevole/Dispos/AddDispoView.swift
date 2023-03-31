//
//  AddDispoView.swift
//  Befest_mobile
//
//  Created by etud on 31/03/2023.
//

import SwiftUI

struct AddDispoView: View {
    @EnvironmentObject var userVM: UserViewModel
    @ObservedObject var listOfCreneau: ListCreneauxVM
    @ObservedObject var listOfZones: ListZoneVM
    @ObservedObject var listOfJours: ListJoursVM
    
    private var intentDispo: DispoIntent = DispoIntent(model: DisponibiliteViewModel(dispo_creneau: GetDispoCreneauDTO(id: 0, creneau_dispo: 0, heure_debut: "", heure_fin: "", jour: "")))
    
    private var intentListCreneau: CreneauListIntent
    private var intentListZones: ZoneListIntent
    private var intentListJours: JourListIntent
    
    
    @State var selectedJour: Int = 0
    @State var selectedCreneau: Int = 0
    
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    ForEach(listOfJours.listOfJours, id: \.id){ jour in
                        VStack{
                            Text("\(jour.name)")
                                .bold()
                                .font(.system(size: 20))
                            
                            Spacer()
                            
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
                            
                            
                            if(selectedJour == jour.id){
                                VStack{
                                    ForEach(listOfCreneau.listOfCreneaux, id: \.id){
                                        creneau in
                                        VStack{
                                            HStack{
                                                Text("\(creneau.heure_debut)-\(creneau.heure_fin)")
                                                
                                                Button("Choisir"){
                                                    let dispoDTO = PostDisponibiliteDTO(id: 0, user_dispo: userVM.id, creneau_dispo: creneau.id)
                                                    self.intentDispo.createDispo(dispo: dispoDTO)
                                                }
                                                
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
