//
//  FestivalItemList.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI

struct FestivalItemView: View {
    @ObservedObject var festivalVM: FestivalViewModel
    
    var body: some View {
        HStack{
            Text(festivalVM.name)
                .foregroundColor(.blue)
            
        }
        
    }
    
    init(festivalVM: FestivalViewModel) {
        self.festivalVM = festivalVM
    }
}
