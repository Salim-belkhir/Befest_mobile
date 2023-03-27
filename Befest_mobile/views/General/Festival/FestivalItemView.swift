//
//  FestivalItemList.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI

struct FestivalItemView: View {
    @EnvironmentObject var userMV: UserViewModel
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var festivalVMItem: FestivalViewModel
    private var intent: FestivalIntent
    
    private var colorBtn: Color {
        return (self.festivalVMItem.closed ? .red : .green)
    }
    
    private var textButton: String{
        return (self.festivalVMItem.closed && (self.userMV.role == "benevole") ? "Fermé" : "Choisir")
    }
    
    var body: some View {
        HStack{
            VStack{
                Text(festivalVMItem.name)
                    .foregroundColor(.blue)
                Text(festivalVMItem.year)
            }
            
            Text("\(self.festivalVMItem.numberOfBenevoles) participants")
            
            Button("Choisir"){
                self.intent.changeMainFestival(oldFestival: festivalVM)
            }
                .padding(5)
                .background(colorBtn)
                .cornerRadius(10)
                .disabled(self.festivalVMItem.closed)
        }
        
    }
    
    init(festivalVMItem: FestivalViewModel) {
        self.festivalVMItem = festivalVMItem
        self.intent = FestivalIntent(model: festivalVMItem)
    }
}
