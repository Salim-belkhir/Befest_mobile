//
//  EditItemCreneauView.swift
//  Befest_mobile
//
//  Created by m1 on 02/04/2023.
//

import SwiftUI

struct EditItemCreneauView: View {
    @ObservedObject var creneau: CreneauViewModel
    private var intent: CreneauIntent
    
    //For the date picker format
    @State private var selectedDebutTime: Date = Date()
    @State private var selectedFinTime: Date = Date()
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer().frame(width:20)
                DatePicker("Heure début:", selection: $selectedDebutTime, displayedComponents: [.hourAndMinute])
                Spacer()
            }
            HStack{
                Spacer().frame(width:20)
                DatePicker("Heure fin :", selection: $selectedFinTime, displayedComponents: [.hourAndMinute])
                Spacer()
            }
            
        }
        .onAppear(){
            let index = creneau.heure_fin.index(creneau.heure_fin.startIndex, offsetBy: 5)
            self.selectedDebutTime = timeFormatter.date(from: creneau.heure_debut.substring(to: index))!
            self.selectedFinTime = timeFormatter.date(from: creneau.heure_fin.substring(to: index))!
        }
        .onChange(of: selectedFinTime) { newValue in
            debugPrint("New State")
            self.intent.changeHeureFin(heure: timeFormatter.string(from: newValue))
        }
        .onChange(of: selectedDebutTime){ newValue in
            debugPrint("NewState")
            self.intent.changeHeureDebut(heure: timeFormatter.string(from: newValue))
        }
    }
    
    init(creneau: CreneauViewModel){
        self.creneau = creneau
        self.intent = CreneauIntent(creneau: creneau)
        
       
    }
}
