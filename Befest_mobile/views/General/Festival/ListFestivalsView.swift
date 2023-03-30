//
//  ListFestivalsView.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI

struct ListFestivalsView: View {
    @ObservedObject var listFestival : FestivalListVM
    private var intent: FestivalListIntent
    @State var isError: Bool = false
    @State var isLoading: Bool = false
    @State var searchText: String = ""
    @EnvironmentObject var festivalVM: FestivalViewModel
    
    
    init() {
        let festivals: FestivalListVM = FestivalListVM()
        self.listFestival = festivals
        self.intent = FestivalListIntent(listFestivals: festivals)
    }
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                    Spacer().frame(height:10)
                HStack(alignment: .lastTextBaseline){
                    Spacer().frame(width: 10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 40)
                            .shadow(radius: 1)
                     
                        HStack(alignment: .center)
                            {
                                Text("Liste des festivals")
                                .font(.title3)
                                .fontWeight(.bold)
                            
                                NavigationLink(destination: AddFestivalView().environmentObject(listFestival)){
                                Image(systemName: "plus.circle.fill")
                                .font(.system(size:30))
                            
                            }
                            
                        }
                    }
                    
                    Spacer().frame(width: 10)
                }
                
                SearchBar(text: $searchText)
                
                List{
                    Section(header:
                                Text("Festivals existants")
                    
                    ){
                        if(isLoading){
                            ProgressView()
                        }
    
                        ForEach(searchResults, id: \.id){ item in
                            FestivalItemView(festivalVMItem: item)
                        }
                        .onMove{
                            indexSet, index in
                            self.intent.move(fromOffsets: indexSet, toOffset: index)
                        }
                        .onDelete{
                            indexSet in
                            Task{
                                await self.intent.delete(at: indexSet)
                            }
                        }
                        
                        
                        EditButton()
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                    }
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    DisconnectNavBar()
                }
            }        
        }
        .onChange(of: self.listFestival.state){
            newValue in
            switch(newValue){
            case .error:
                self.isError = true
            case .loading:
                self.isLoading = true
            case .ready:
                self.isLoading = false
            default:
                break
            }
        }
        .alert(isPresented: self.$isError){
            Alert(title: Text("Un erreur s'est produite"), message: Text("Une erreur s'est produite lors de la modification de la liste. Veuillez réessayer plus tard"))
        }
        .task {
            await self.intent.getData()
        }
        
    }
    
    var searchResults: [FestivalViewModel] {
        if(searchText.isEmpty) {
            return self.listFestival.listOfFestivals
        }
        else{
            return self.listFestival.listOfFestivals.filter {
                $0.name.contains(searchText)
            }
        }
    }
    
}
