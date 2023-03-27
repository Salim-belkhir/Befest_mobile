//
//  ListBenevolesView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct ListBenevolesView: View {
    @ObservedObject var listBenevolesVM: BenevolesListVM
    private var intent: UserListIntent
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $searchText)
                
                List{
                    ForEach(searchResults, id: \.id){
                        item in
                        Text(item.firstname)
                    }
                }
            }
        }
    }
    
    
    
    
    init(){
        let listBenevoles = BenevolesListVM()
        self.listBenevolesVM = listBenevoles
        self.intent = UserListIntent(listBenevoles: listBenevoles)
    }
    
    
    var searchResults: [UserViewModel] {
        if(searchText.isEmpty) {
            return self.listBenevolesVM.listOfBenevoles
        }
        else{
            return self.listBenevolesVM.listOfBenevoles.filter {
                $0.firstname.contains(searchText)
            }
        }
    }
}

