//
//  AffecterDispoView.swift
//  Befest_mobile
//
//  Created by etud on 31/03/2023.
//

import SwiftUI

struct AffecterDispoView: View {
    
    @ObservedObject var dispoVM: DisponibiliteViewModel
    @State var zoneSelected: ZoneViewModel = ZoneViewModel(id: 0, name: "Vide", number_benevoles_needed: 2)
    @ObservedObject var listZones: ListZoneVM
    private var intentZoneList: ZoneListIntent
    @EnvironmentObject var festivalVM: FestivalViewModel
    private var userid: Int
    private var intentDispo : DispoIntent
    
    var body: some View {
        ScrollView{
            VStack (alignment: .center, spacing: 10 ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 50)
                        .shadow(radius: 1)
                    
                    Text("Affectation du bénévole")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "clock")
                            .font(.title2)
                            .foregroundColor(.purple)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(dispoVM.creneau?.jour_name ?? "")
                                .font(.headline)
                            
                            Text("\(dispoVM.creneau?.heure_debut ?? "") - \(dispoVM.creneau?.heure_fin ?? "")")
                                .font(.subheadline)
                        }
                        .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("Choisir une zone")
                            .foregroundColor(Color.purple)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        
                        Picker("Choisir une zone", selection: $zoneSelected) {
                            Text("Aucune Zone")
                            ForEach(listZones.listOfZones, id: \.self) { item in
                                Text(item.name)
                            }
                        }
                        .frame(maxWidth: 300)
                        .pickerStyle(WheelPickerStyle())
                    }
                    
                    Button(action: {
                        // action à exécuter lors du clic sur le bouton
                        if(zoneSelected.id == 0)
                        {
                            return
                        }
                            
                        self.intentDispo.createAffectation(idUser: userid,idZone: zoneSelected.id, idCreneau: dispoVM.creneau?.id ?? 0)
                    }) {
                        Text("Affecter")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .shadow(radius: 5)
                    .fixedSize()
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 40)
                
            }
            .onAppear() {
                self.intentZoneList.getData(festival: festivalVM.id)
            }
        }
    }
    
    init(dispo: DisponibiliteViewModel, userid: Int) {
        self.dispoVM = dispo
        let listZones = ListZoneVM()
        self.listZones = listZones
        self.intentZoneList = ZoneListIntent(listOfZones: listZones)
        self.intentDispo = DispoIntent(model: dispo)
        self.userid = userid
    }
}

