import SwiftUI

// Définition de la vue EditFestivalView
struct EditFestivalView: View {
    // Utilisation de l'environnement pour accéder à la variable festivalVM
    @EnvironmentObject var festivalVM: FestivalViewModel
    // Utilisation de l'état pour stocker l'intention de modification du festival
    @State var intent: FestivalIntent?

    // Corps de la vue
    var body: some View {
        // Utilisation de la NavigationView
        NavigationView{
            // Utilisation d'un VStack pour organiser les éléments de la vue
            VStack {
                // Section pour les informations du festival
                Section(header:
                    // Utilisation d'un ZStack pour ajouter un arrière-plan à l'en-tête
                    ZStack {
                        // Utilisation d'un RoundedRectangle pour le fond
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 50)
                            .shadow(radius: 1)
                        // Ajout du texte de l'en-tête
                        Text("Informations du festival")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                ){
                    // Utilisation d'un VStack pour organiser les champs d'information
                    VStack(alignment: .leading) {
                        // Utilisation d'un HStack pour le champ de nom du festival
                        HStack() {
                            // Utilisation d'un RoundedRectangle pour le fond
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 50)
                                    .frame(width: 150)
                                    .shadow(radius: 1)
                                // Ajout du texte pour le champ de nom
                                Text("Nom du festival")
                                    .fontWeight(.bold)
                            }
                            // Utilisation d'un TextField pour saisir le nom du festival
                            TextField("Nom du festival", text: $festivalVM.name)
                                .padding(12)
                                .padding(.horizontal)
                                .background(
                                    Color(UIColor.systemGray6)
                                )
                                .cornerRadius(10)
                                .previewLayout(.sizeThatFits)
                                .fixedSize()
                                .shadow(radius: 2)
                        }
                        .fixedSize()
                        // Utilisation d'un HStack pour le champ d'année
                        HStack(spacing: 6) {
                            // Utilisation d'un RoundedRectangle pour le fond
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 50)
                                    .frame(width:150)
                                    .shadow(radius: 1)
                                // Ajout du texte pour le champ d'année
                                Text("Année")
                                    .fontWeight(.bold)
                            }
                            // Utilisation d'un TextField pour saisir l'année du festival
                            TextField("Année", text: $festivalVM.year)
                                .padding(12)
                                .padding(.horizontal)
                                .background(
                                    Color(UIColor.systemGray6)
                                )
                                .cornerRadius(10)
                                .previewLayout(.sizeThatFits)
                                .fixedSize()
                                .shadow(radius: 2)
                        }
                        .fixedSize()
                        // Utilisation d'un HStack pour les boutons Enregistrer et Clôturer
                        HStack(spacing:6){
                            // Utilisation d'un bouton pour enregistrer les modifications
                            Button(action: {
                                // Enregistrer les changements et quitter la page d'édition
                                Task{
                                    await self.intent!.updateFestival()
                                }
                            }) {
                                    Text("Enregistrer")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                }
                                .padding(15)
                                .background(Color.purple)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                
                                Button(action: {
                                    Task{
                                        await self.intent!.closeFestival()
                                        debugPrint(festivalVM.closed)
                                    }
                                })
                                {
                                    Text("Clôturer")
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }
                                .padding(15)
                                .background(Color.accentColor)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                            }
                            .previewLayout(.sizeThatFits)
                            .fixedSize()
                            
                        }
                    }
                    .padding(.horizontal, 20) // Ajouter du padding horizontal
                    // Ajouter d'autres champs pour les informations du festival
                    
                    Spacer()
                }
                
                
                .toolbar{
                    ToolbarItem(placement: .principal){
                        NameFestivalNavBar()
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        DisconnectNavBar()
                    }
                }
                        
            }
            .onAppear {
                self.intent = FestivalIntent(model: festivalVM)
            }
        }
    }

