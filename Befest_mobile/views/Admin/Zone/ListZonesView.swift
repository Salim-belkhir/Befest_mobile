// ListZonesView.swift
//
// Cette vue affiche la liste des zones du festival en cours. Elle permet d'ajouter, de supprimer et de réorganiser des zones.
// Elle permet également de rechercher une zone en particulier.

import SwiftUI

struct ListZonesView: View {
    @EnvironmentObject var festivalVM: FestivalViewModel // View model de l'objet festival courant
    @ObservedObject var listOfZones: ListZoneVM // View model de la liste des zones du festival courant
    private var intent: ZoneListIntent // Intent de la liste des zones du festival courant
    @State var searchText: String = "" // Texte de recherche
    @State var isLoading: Bool = false // Chargement de la liste des zones

    var body: some View {
        NavigationView{
            VStack{
                HStack(alignment: .lastTextBaseline){
                    Spacer()
                    // Bouton d'ajout d'une zone
                    NavigationLink(destination: AddZoneView().environmentObject(listOfZones)){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size:40))
                    }
                    Spacer().frame(width: 10)
                }
                
                // Barre de recherche
                SearchBar(text: $searchText)
                
                List{
                    // Affichage d'un indicateur de chargement si la liste des zones est en cours de chargement
                    if(isLoading){
                        ProgressView()
                    }
                    else{
                        // Affichage des zones et possibilité de les supprimer ou de les réorganiser
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
                        
                        // Bouton d'édition
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
                    NameFestivalNavBar() // Affichage du nom du festival courant dans la barre de navigation
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    DisconnectNavBar() // Bouton de déconnexion dans la barre de navigation
                }
            }
        }
        .task{
            self.intent.getData(festival: festivalVM.id) // Récupération des données des zones du festival courant
        }
        .onChange(of: self.listOfZones.state){
            newValue in
            // Affichage de l'indicateur de chargement en fonction de l'état de la liste des zones
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

    // Fonction de recherche des zones
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
