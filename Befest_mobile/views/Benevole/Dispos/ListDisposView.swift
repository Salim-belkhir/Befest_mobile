//
//  ListDisposView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct ListDisposView: View {
    @EnvironmentObject var userMV: UserViewModel
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listDisposVM: ListDisponibilitesVM
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    
    init(){
        self.listDisposVM = ListDisponibilitesVM()
    }
}

struct ListDisposView_Previews: PreviewProvider {
    static var previews: some View {
        ListDisposView()
    }
}
