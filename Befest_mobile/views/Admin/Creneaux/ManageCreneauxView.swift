//
//  ManageCreneauxView.swift
//  Befest_mobile
//
//  Created by m1 on 02/04/2023.
//

import SwiftUI

struct ManageCreneauxView: View {
    @ObservedObject var jour: JourViewModel
    @ObservedObject var listCreneaux: ListCreneauxVM
    
    private var intentListCreneaux: CreneauListIntent
    
    @State var isError: Bool = false
    @State var issuccess: Bool = false
    
    @State private var creneauxToDelete: [Int] = []
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Text(jour.name)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Text("Heure d'ouverture : \(jour.heure_ouverture)")

                    Text("Heure de fermeture : \(jour.heure_fermeture)")
                    
                    Spacer().frame(height:20)
                    
                    if(listCreneaux.listOfCreneaux.isEmpty){
                        Text("Pas de créneaux existants pour cette journée.\nCréez-en un!")
                        Spacer().frame(height: 50)
                        Button("Ajouter un créneau"){
                            self.createFirstCreneau()
                        }
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.blue)
                        .cornerRadius(10)
                    }
                    else{
                        if(isPossibleToAddFirst()){
                            Button("Ajouter un créneau"){
                                self.listCreneaux.listOfCreneaux.insert(CreneauViewModel(id: 0, heure_debut: jour.heure_ouverture, heure_fin: self.sortedCreneaux[0].heure_debut), at: 0)
                            }
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue)
                            .cornerRadius(10)
                        }
                        ForEach(sortedCreneaux, id: \.uuid){
                            creneau in
                            HStack{
                                EditItemCreneauView(creneau: creneau)
                                Button("Supprimer"){
                                    if(creneau.id == 0){
                                        intentListCreneaux.deleteElement(uuid: creneau.uuid)
                                    }
                                    else{
                                        self.creneauxToDelete.append(creneau.id)
                                        intentListCreneaux.deleteElement(uuid: creneau.uuid)
                                    }
                                }
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.red)
                                .cornerRadius(10)
                            }
                            .padding(10)
                        }
                        if(isPossibleToAddEnd()){
                            Button("Ajouter un créneau"){
                                self.listCreneaux.listOfCreneaux.append(CreneauViewModel(id: 0, heure_debut: self.sortedCreneaux[sortedCreneaux.count-1].heure_fin, heure_fin: jour.heure_fermeture))
                            }
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue)
                            .cornerRadius(10)
                        }
                        
                        Button("Enregistrer"){
                            if(verifyInformations() && verifyValidity()){
                                self.updateCreneaux()
                                self.issuccess = true
                            }
                            else{
                                isError = true
                            }
                        }
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.purple)
                        .cornerRadius(10)
                    }
                }
                .onAppear(){
                    self.intentListCreneaux.getData(jour: jour.id)
                }
            }
            .alert(isPresented: $isError){
                Alert(title: Text("Une erreur s'est produite"), message: Text("Vous avez mal mis en place les heures"))
            }
            .alert(isPresented: $issuccess){
                Alert(title: Text("Succés !"), message: Text("Les créneaux ont bien été mis à jour"))
            }
        }
    }
    
    
    var sortedCreneaux: [CreneauViewModel] {
        if(self.listCreneaux.listOfCreneaux.isEmpty){
            return self.listCreneaux.listOfCreneaux
        }
        else{
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return self.listCreneaux.listOfCreneaux.sorted { (creneau1, creneau2) -> Bool in
                guard let date1 = formatter.date(from: creneau1.heure_debut), let date2 = formatter.date(from: creneau2.heure_debut) else {
                    return false
                }
                return date1 < date2
            }
        }
    }
    
    func updateCreneaux(){
        for i in creneauxToDelete{
            self.intentListCreneaux.deleteCreneau(id: i)
        }
        debugPrint("J'ai fini de supprimer")
        self.intentListCreneaux.updateList(jour: jour.id)
    }
    
    func verifyInformations() -> Bool{
        let first_creneau: CreneauViewModel? = sortedCreneaux.first
        let last_creneau: CreneauViewModel? = sortedCreneaux.last
        let index = jour.heure_ouverture.index(jour.heure_ouverture.startIndex, offsetBy: 5)
        let heureDebut = jour.heure_ouverture.substring(to: index)
        let heureFin = jour.heure_fermeture.substring(to: index)
        
        let result = first_creneau != nil && last_creneau != nil && first_creneau?.heure_debut == heureDebut && last_creneau?.heure_fin == heureFin

        return result
    }
    
    func verifyValidity() -> Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        debugPrint(sortedCreneaux.count)
        for i in 0..<sortedCreneaux.count-1{
            guard let heure1 = formatter.date(from: sortedCreneaux[i].heure_fin), let heure2 = formatter.date(from: sortedCreneaux[i+1].heure_debut) else {
                return false
            }
            if(heure1 > heure2){
                return false
            }
        }
        return true
    }
    
    func createFirstCreneau() {
        let creneau = CreneauViewModel(id: 0, heure_debut: jour.heure_ouverture, heure_fin: jour.heure_fermeture)
        self.listCreneaux.listOfCreneaux.append(creneau)
    }
    
    func isPossibleToAddFirst() -> Bool {
        return sortedCreneaux[0].heure_debut != jour.heure_ouverture
    }
    
    func isPossibleToAddEnd() -> Bool {
        return sortedCreneaux[sortedCreneaux.count-1].heure_fin != jour.heure_fermeture
    }
    
    
    init(jour: JourViewModel){
        let listCreneaux = ListCreneauxVM()
        self.listCreneaux = listCreneaux
        self.intentListCreneaux = CreneauListIntent(listCreneauVM: listCreneaux)
        self.jour = jour
    }
}

