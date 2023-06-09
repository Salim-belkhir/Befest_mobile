//
//  AddFestivalView.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import SwiftUI

struct AddFestivalView: View {
    // Variables d'état pour stocker les valeurs entrées par l'utilisateur
    @State var stepper_value: Int
    @State var text_name: String = ""
    @State var text_year: String = ""
    @State var showAlert: Bool = false
    @State var messageAlert: String = ""
    @State var titleAlert: String = ""

    // Variables d'environnement et d'observation pour communiquer avec le modèle de données
    @EnvironmentObject var listFestival: FestivalListVM
    @ObservedObject var festivalVM: FestivalViewModel
    private var intent: FestivalIntent
    
    // Corps de la vue
    var body: some View {
        NavigationView{
            VStack {
                // Entête de la vue
                HStack
                {
                    Spacer().frame(width:10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 40)
                            .shadow(radius: 1)
                        Text("Liste des festivals")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    
                    Spacer().frame(width:10)
                }
                                
                // Formulaire pour entrer les informations sur le festival
                Form {
                    Section(header: Text("Informations sur le festival")) {
                        TextField("Nom du festival", text: $text_name)
                            .onChange(of: text_name){ newValue in
                                self.intent.changeName(name: newValue)
                            }
                            
                        TextField("Année", text: self.$festivalVM.year)
                        
                        // Stepper pour entrer le nombre de jours du festival
                        HStack{
                            Text("Nombre de jours: \(self.festivalVM.nbOfDays)")
                            Stepper("", value: $stepper_value, in: 2...100)
                                .onChange(of: stepper_value) {
                                    newValue in
                                    self.intent.changeNbOfDays(number: newValue)
                                }
                        }
                    }
                }.frame(maxHeight: 300)
                
                Spacer()
                
                // Bouton pour ajouter le festival
                HStack(alignment: .lastTextBaseline) {
                    Spacer()
                    Button(action: {
                        Task{
                            await self.intent.createFestival(listFestival: listFestival)
                        }
                    }) {
                        Text("Ajouter")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(10)
                    
                    Spacer().frame(width: 30)
                }
                Spacer()
                
            }
            .navigationTitle("Ajouter un festival")
        }
        // Alert pour afficher les messages de succès ou d'erreur
        .alert(isPresented: $showAlert){
            Alert(title: Text(self.titleAlert), message: Text(self.messageAlert))
        }
        // Observer le changement d'état du festival créé pour afficher le message approprié
        .onChange(of: self.festivalVM.state){
            newValue in
            debugPrint("New state of the festival create")
            switch newValue{
            case .error:
                self.titleAlert = "Erreur"
                self.messageAlert = "Erreur dans la création du festival"
                self.showAlert = true
            case .successCreate:
                self.titleAlert = "Succés"
                self.messageAlert = "Festival créé !"
                self.showAlert = true
            default:
                break
            }
        }
        
    }
    
    
    init(){
        let festival = FestivalViewModel(id: 0, name: "", year: "", nbOfDays: 0, closed: false, numberOfBenevoles: 0)
        self.festivalVM = festival
        self.intent = FestivalIntent(model: festival)
        self.stepper_value = 2
    }
}



/*
 
 onEditingChanged: {
     (isChanged) in
     if(!isChanged){
         if let year = Int(text_year) {
             let currentYear = Calendar.current.component(.year, from: Date())
             if year < currentYear || year > 2178 {
                 self.isError = true
                 }
             else{
                 self.isError = false
                 self.intent.changeYear(year: text_year)
             }
         }
         else{
             self.isError = true
         }
     }
     
     }
 
 */
