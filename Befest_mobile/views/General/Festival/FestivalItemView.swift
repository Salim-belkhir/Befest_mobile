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
        return ((self.festivalVMItem.closed && self.userMV.role == "benevole") ? "Fermé" : "Choisir")
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Text(festivalVMItem.name)
                        .foregroundColor(.blue)
                        .font(.system(size: 17))
                    Spacer()
                    Text("Année: \(festivalVMItem.year)")
                        .font(.system(size: 14))
                }
                
                Text("\(self.festivalVMItem.numberOfBenevoles) participants")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
            }
            
            
            
            Spacer()
            
            Button(textButton){
                self.intent.changeMainFestival(oldFestival: festivalVM)
            }
                .padding(10)
                .background(colorBtn)
                .cornerRadius(10)
                .disabled(self.festivalVMItem.closed && self.userMV.role == "benevole")
                .frame(width: 100, height: 40)
        }
        .padding(10)
        .cornerRadius(10)
        
    }
    
    init(festivalVMItem: FestivalViewModel) {
        self.festivalVMItem = festivalVMItem
        self.intent = FestivalIntent(model: festivalVMItem)
        
    }
}
