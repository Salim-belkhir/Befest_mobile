//
//  CreneauxZoneView.swift
//  Befest_mobile
//
//  Created by etud on 31/03/2023.
//

import SwiftUI

struct CreneauxZoneView: View {
    private var idCreneau: Int
    @ObservedObject var zoneVM: ZoneViewModel
    @ObservedObject var listBenevoles: BenevolesListVM
    private var intentlistBenevoles: UserListIntent
    @State private var showBenevoles: Bool = false
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer().frame(width: 10)
                Text("\(zoneVM.name)")
                    .padding(10)
                
                
                Spacer()
                
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
            
            
            if(showBenevoles){
                ScrollView{
                    if(listBenevoles.state == .loading){
                        ProgressView()
                    }
                    else{
                        if(listBenevoles.listOfBenevoles.count == 0){
                            Text("Pas d'affectations existantes")
                        }
                        else{
                            ForEach(listBenevoles.listOfBenevoles, id: \.id){ benevole in
                                BenevoleItemView(benevole: benevole)
                            }
                        }
                    }
                }
                .onAppear(){
                    self.intentlistBenevoles.getDataForCreneauForZone(zone: self.zoneVM.id, creneau: idCreneau)
                }
            }
            
        }
    }
    
    
    init(zone: ZoneViewModel, idCreneau: Int){
        self.zoneVM = zone
        let listBenevoles = BenevolesListVM()
        self.listBenevoles = listBenevoles
        self.intentlistBenevoles = UserListIntent(listBenevoles: listBenevoles)
        self.idCreneau = idCreneau
    }
}
