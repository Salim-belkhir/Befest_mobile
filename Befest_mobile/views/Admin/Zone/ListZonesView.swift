//
//  ListZonesView.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import SwiftUI

struct ListZonesView: View {
    @ObservedObject var listOfZones: ListZoneVM
    
    var body: some View {
        VStack{
            
        }
    }
    
    init(){
        self.listOfZones = ListZoneVM()
    }
}

struct ListZonesView_Previews: PreviewProvider {
    static var previews: some View {
        ListZonesView()
    }
}
