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
    
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                SearchBar(text: $searchText)
                
                List{
                    if(isLoading){
                        ProgressView()
                    }
                    else{
                        ForEach(searchResults, id: \.id){
                            item in
                            NavigationLink(destination: BenevoleDetailView(benevole: item)){
                                BenevoleItemView(benevole: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Bénévoles"))
            .toolbar{
                ToolbarItem(placement: .principal){
                    NameFestivalNavBar()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    DisconnectNavBar()
                }
            }
            .onAppear() {
                self.intent.getData()
            }
            .onChange(of: self.listBenevolesVM.state){
                newValue in
                switch newValue{
                case .loading:
                    self.isLoading = true
                case .ready:
                    self.isLoading = false
                default:
                    break
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

