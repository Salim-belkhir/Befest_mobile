//
//  FestivalItemList.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI

struct FestivalItemView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var festivalVMItem: FestivalViewModel
    private var intent: FestivalIntent
    
    private var colorBtn: Color {
        return (self.festivalVMItem.closed ? .blue : .purple)
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
                .padding()
                .background(colorBtn)
                .cornerRadius(10)
        }
        
    }
    
    init(festivalVMItem: FestivalViewModel) {
        self.festivalVMItem = festivalVMItem
        self.intent = FestivalIntent(model: festivalVMItem)
    }
}
