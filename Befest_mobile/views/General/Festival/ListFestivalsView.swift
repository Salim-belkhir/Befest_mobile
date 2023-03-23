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
    
    
    init() {
        let festivals: FestivalListVM = FestivalListVM()
        self.listFestival = festivals
        self.intent = FestivalListIntent(listFestivals: festivals)
    }
    
    
    var body: some View {
        
        VStack{
            
            if(isError){
                Text("Une erreur s'est produite")
            }
            
            if(isLoading){
                Text("Loading")
            }
            
            List{
                Section(header: Text("Festivals existants")){
                    ForEach(listFestival.listOfFestivals, id: \.id){ item in
                        FestivalItemView(festivalVM: item)
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
                }
            }
            
        }
        .toolbar{
            Button{
                debugPrint("Pressed")
            } label: {
                Image(systemName: "plus.circle.fill")
                    .frame(width: 100)
            }
        }
        .onChange(of: self.listFestival.state){
            newValue in
            debugPrint("New state: \(newValue)")
            switch(newValue){
            case .error:
                self.isError = true
            case .loading:
                self.isLoading = true
            case .ready:
                self.isError = false
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
}

struct ListFestivalsView_Previews: PreviewProvider {
    static var previews: some View {
        ListFestivalsView()
    }
}
