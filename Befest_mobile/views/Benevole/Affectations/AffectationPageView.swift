//
//  ListAffectationView.swift
//  Befest_mobile
//
//  Created by etud on 31/03/2023.
//

import SwiftUI

//  This View allows to show the page that contains the list of affectations of the benevole
//  He can delete his affectations

struct AffectationPageView: View {
    //The environment variables, for getting informations about the main festival and the user connected
    @EnvironmentObject var festivalVM: FestivalViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    @ObservedObject var listAffectations: ListAffectationsVM
    private var intentListAffectations: AffectationListIntent
    
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    if(isLoading){
                        ProgressView()
                    }
                    
                    ForEach(listAffectations.listOfAffectations, id: \.id){
                        affectation in
                        ItemAffectationView(affectation: affectation)
                    }
                    
                    .onDelete{
                        index in
                        self.intentListAffectations.delete(at: index)
                    }
                    .onMove{
                        indexSet, index in
                        self.intentListAffectations.move(fromOffsets: indexSet, toOffset: index)
                    }
                    
                    EditButton()
                        .padding(9)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
            }
            .onAppear(){
                self.intentListAffectations.getData(user: userVM.id, festival: festivalVM.id)
            }
            .navigationTitle(Text("Mes affectations"))
            .toolbar{
                ToolbarItem(placement: .principal){
                    NameFestivalNavBar()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    DisconnectNavBar()
                }
            }
        }
        .onChange(of: self.listAffectations.state){
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
    
    init(){
        let listOfAffectations = ListAffectationsVM()
        self.listAffectations = listOfAffectations
        self.intentListAffectations = AffectationListIntent(listAffectationVM: listOfAffectations)
    }
}
