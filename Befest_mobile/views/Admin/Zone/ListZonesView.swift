//
//  ListZonesView.swift
//  Befest_mobile
//
//  Created by m1 on 23/03/2023.
//

import SwiftUI

struct ListZonesView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel
    @ObservedObject var listOfZones: ListZoneVM
    private var intent: ZoneListIntent
    @State var searchText: String = ""
    
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                
                HStack(alignment: .lastTextBaseline){
                    Spacer()
                    
                    NavigationLink(destination: AddZoneView().environmentObject(listOfZones)){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size:40))
                        
                    }
                    
                    
                    Spacer().frame(width: 10)
                }
                
                SearchBar(text: $searchText)
                
                List{
                    if(isLoading){
                        ProgressView()
                    }
                    else{
                        ForEach(searchResults, id: \.id){  item in
                            NavigationLink(destination: EditZoneView(zone: item)){
                                ZoneItemView(zone: item)
                            }
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
                            .padding(7)
                            .background(Color.blue)
                            .cornerRadius(6)
                    }

                }
            }
            .navigationTitle(Text("Zones"))
            .toolbar{
                ToolbarItem(placement: .principal){
                    NameFestivalNavBar()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    DisconnectNavBar()
                }
            }
        }
        .task{
            self.intent.getData(festival: festivalVM.id)
        }
        .onChange(of: self.listOfZones.state){
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
        let listVM: ListZoneVM = ListZoneVM()
        self.listOfZones = listVM
        self.intent = ZoneListIntent(listOfZones: listVM)
    }
    
    
    var searchResults: [ZoneViewModel] {
        if(searchText.isEmpty) {
            return self.listOfZones.listOfZones
        }
        else{
            return self.listOfZones.listOfZones.filter {
                $0.name.contains(searchText)
            }
        }
    }
}
