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
                        .bold()
                        .font(.system(size: 17))
                    Spacer()
                    Text("Année: \(festivalVMItem.year)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                HStack{
                    Image(systemName: "person.3.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Text("\(self.festivalVMItem.numberOfBenevoles) participants")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
            }
            
            Button(action: {
                self.intent.changeMainFestival(oldFestival: festivalVM)
            }, label: {
                Text(textButton)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .bold()
                    .padding(8)
                    .background(colorBtn)
                    .cornerRadius(16)
                    .frame(width: 80)
            })
            .disabled(self.festivalVMItem.closed && self.userMV.role == "benevole")
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.4),radius: 1)
        
    }
    
    init(festivalVMItem: FestivalViewModel) {
        self.festivalVMItem = festivalVMItem
        self.intent = FestivalIntent(model: festivalVMItem)
    }
}

