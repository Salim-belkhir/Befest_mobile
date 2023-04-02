// Ce fichier correspond à la vue de gestion du compte utilisateur.
// Il permet à l'utilisateur de consulter, modifier et enregistrer ses informations personnelles.
//
// Import de la bibliothèque SwiftUI pour la création d'interfaces utilisateur.
import SwiftUI

// Définition de la vue de gestion du compte utilisateur.
struct AccountView: View {
    // Récupération du ViewModel de l'utilisateur via l'environnement de la vue.
    @EnvironmentObject var userMV: UserViewModel
    // Variables d'état pour la gestion du mode d'édition et de l'intention de modification.
    @State private var editingMode = false
    @State private var intent : LogIntent?

    // Variable calculée qui retourne la couleur de la vue en fonction du mode d'édition.
    private var color: Color {
        return editingMode ? .purple : .accentColor
    }

    // Corps de la vue.
    var body: some View {
        // Utilisation d'une vue de navigation pour la mise en place de la barre de navigation.
        NavigationView {
            // Empilement vertical des différents éléments de la vue.
            VStack(alignment: .center, spacing: 20) {
                
                
                // Image représentant l'utilisateur connecté.
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
                
                // Bloc d'affichage des informations personnelles de l'utilisateur.
                VStack(alignment: .leading) {
                    // Champ d'édition du prénom de l'utilisateur.
                    HStack {
                        Text("Prénom")
                            .foregroundColor(.secondary)
                        
                        // Affichage du champ d'édition en mode édition.
                        if editingMode {
                            TextField("Prénom", text: $userMV.firstname)
                                .padding(12)
                                .padding(.horizontal)
                                .background(
                                    Color(UIColor.systemGray6)
                                )
                                .cornerRadius(10)
                                .previewLayout(.sizeThatFits)
                                .fixedSize()
                                .shadow(radius: 1)
                        } else {
                            // Affichage du prénom en mode lecture.
                            Text("\(userMV.firstname)")
                                .foregroundColor(Color.accentColor)
                        }
                    }
                    .padding()
                    
                    // Champ d'édition du nom de l'utilisateur.
                    HStack {
                        Text("Nom")
                            .foregroundColor(.secondary)
                        
                        Spacer().frame(width: 33)
                        
                        // Affichage du champ d'édition en mode édition.
                        if editingMode {
                            TextField("Nom", text: $userMV.lastname)
                                .padding(12)
                                .padding(.horizontal)
                                .background(
                                    Color(UIColor.systemGray6)
                                )
                                .cornerRadius(10)
                                .previewLayout(.sizeThatFits)
                                .fixedSize()
                                .shadow(radius: 1)
                                
                        } else {
                            // Affichage du nom en mode lecture.
                            Text("\(userMV.lastname)")
                                .foregroundColor(Color.accentColor)
                        }
                    }
                    .padding()
                    
                    // Champ d'édition de l'adresse email de l'utilisateur.
                    HStack {
                        Text("Email")
                            .foregroundColor(.secondary)
                        
                        Spacer().frame(width: 25)
                        
                        // Affichage du champ d'édition en mode édition.
                        if editingMode {
                            TextField("Email", text: $userMV.email)
                                .padding(12)
                                .padding(.horizontal)
                                .background(
                                    Color(UIColor.systemGray6)
                                )
                                .cornerRadius(10)
                                .previewLayout(.sizeThatFits)
                                .fixedSize()
                                .shadow(radius: 1)
                            } else {
                                Text("\(userMV.email)")
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                        .padding()

                    }
                    
                    if editingMode {
                        Button(action: {
                            // Enregistrer les modifications
                            self.editingMode.toggle()
                            self.intent?.updateUser()
                        }) {
                            Text("Enregistrer")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.purple)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    } else {
                        Button(action: {
                            self.editingMode.toggle()
                        }) {
                            Text("Modifier")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
            }
            .onAppear(){
                self.intent = LogIntent(model: userMV)
            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .principal){
                    NameFestivalNavBar()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    DisconnectNavBar()
                }
            }
            .navigationTitle(Text("Mon compte"))
        }
    }
}
