//
//  ListFestivalsView.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI

struct ListFestivalsView: View {
    @State var listFestival : [FestivalViewModel] = []
    
    
    
    var body: some View {
        
        List{
            ForEach(listFestival, id: \.id){ item in
                FestivalItemView(festivalVM: item)
            }
        }
        .onAppear(perform: {
            self.listFestival = try await FestivalService.getAllFestivals()
        })
    }
}

struct ListFestivalsView_Previews: PreviewProvider {
    static var previews: some View {
        ListFestivalsView()
    }
}
