//
//  AccountView.swift
//  Befest_mobile
//
//  Created by etud on 27/03/2023.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var userMV: UserViewModel
    @State private var editingMode = false
    @State private var intent : LogIntent?
    
    private var color: Color {
        return editingMode ? .purple : .accentColor
    }
    
    

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Mon compte")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
                .padding()

            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading)
            {
                HStack {
                    Text("Prénom")
                        .foregroundColor(.secondary)
                    

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
                        Text("\(userMV.firstname)")
                        .foregroundColor(Color.accentColor)
                    }
                }
                .padding()

                HStack {
                    Text("Nom")
                        .foregroundColor(.secondary)
                    
                        Spacer().frame(width: 33)

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
                         Text("\(userMV.lastname)")
                            .foregroundColor(Color.accentColor)
                    }
                }
                .padding()

                HStack {
                    Text("Email")
                        .foregroundColor(.secondary)
                    
                    Spacer().frame(width: 25)
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
        
    }
}
