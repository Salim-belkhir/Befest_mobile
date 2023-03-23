//
//  FestivalItemList.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI

struct FestivalItemView: View {
    @ObservedObject var festivalVM: FestivalViewModel
    private var color: Color {
        return (self.festivalVM.closed ? .blue : .red)
    }
    
    var body: some View {
        HStack{
            VStack{
                Text(festivalVM.name)
                    .foregroundColor(.blue)
                Text(festivalVM.year)
            }
            
            Button("Choisir"){
                
            }
            
        }
        
    }
    
    init(festivalVM: FestivalViewModel) {
        self.festivalVM = festivalVM
    }
}
