//
//  LogView.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI
import Combine


enum TextButton: String{
    case signin = "Se connecter"
    case signup = "S'inscrire"
}


struct LogView: View {
    @ObservedObject var userMV : UserViewModel
    private var intent: LogIntent
    
    @State var isError: Bool = false
    
    @State var isEmailValid: Bool = true
    @State var isLoginPage : Bool = true
    @State var navigate : Bool = false
    
    var texteBas : String {
        return (self.isLoginPage ? "Pas encore inscrit ?\nVous pouvez vous inscrire en cliquant en bas" : "Déjà inscrit(e) ?\nClique ci-bas pour te connecter")
    }
    
    //Allows to manage the state of the page to know if it's a login page or a
    var textButton: TextButton {
        return (self.isLoginPage ? TextButton.signin : TextButton.signup)
    }
    
    
    init(){
        let user : UserViewModel = UserViewModel()
        self.userMV = user
        self.intent = LogIntent(model: user)
    }
    
    
    var body: some View {
        ZStack{
            if(isError){
                VStack{
                    Text("Erreur cher ami")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red.blur(radius: 12))
            }
            NavigationView{
                VStack{
                    Image("Logo-Befest")
                        .resizable()
                        .scaledToFit()
                        .frame(width:150)
                    
                    
                    Text("Welcome to Befest!")
                    
                    if(!isLoginPage){
                        TextField("Nom...", text: $userMV.lastname)
                            .font(.headline)
                            .padding(10)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.2))
                            .frame(width: 300, height: 40, alignment: .center)
                            .cornerRadius(10)
                        
                        TextField("Prénom...", text: $userMV.firstname)
                            .font(.headline)
                            .padding(10)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.2))
                            .frame(width: 300, height: 40, alignment: .center)
                            .cornerRadius(10)
                    }
                    else{
                        Spacer().frame(height: 50)
                    }
                    
                    
                    
                    TextField("Email...", text: $userMV.email, onEditingChanged: {(isChanged) in
                        if(!isChanged){
                            if(EmailValidator.isEmailValid(self.userMV.email)){
                                self.isEmailValid = true
                            }
                            else{
                                self.isEmailValid = false
                                self.intent.changeEmail(email: "")
                            }
                        }
                    })
                    .font(.headline)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.2))
                    .frame(width: 300, height: 40, alignment: .center)
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    
                    
                    if (!self.isEmailValid) {
                        Text("Email is Not Valid")
                            .font(.callout)
                            .foregroundColor(Color.red)
                    }
                    
                    
                    SecureField("Mot de passe...", text: $userMV.password)
                        .font(.headline)
                        .padding(10)
                        .foregroundColor(.black)
                        .background(Color.gray.opacity(0.2))
                        .frame(width: 300, height: 40, alignment: .center)
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    
                    
                    Button(textButton.rawValue, action: {
                        Task{
                            if(isLoginPage){
                                if (await self.intent.signin()) { self.navigate = true }
                            }
                            else{
                                if(await self.intent.signup()) { self.isLoginPage = true }
                            }
                        }
                    })
                    .padding(10)
                    .frame(width: 130)
                    .background(Color.blue.opacity(0.9))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.2), lineWidth: 3))
                    
                    Spacer().frame(height: 50)
                    
                    Text(texteBas)
                        .multilineTextAlignment(TextAlignment.center)
                    
                    
                    Button("Ici") {
                        self.isLoginPage = !self.isLoginPage
                    }
                    
                }
                .onChange(of: self.userMV.state){
                    newValue in
                    switch newValue{
                    case .error(_):
                        debugPrint("Erreur sur le Model View")
                        self.isError = true
                    default:
                        break
                    }
                }
                
                Spacer().frame(height: 100)
                
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true).environmentObject(userMV), isActive: $navigate){
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
