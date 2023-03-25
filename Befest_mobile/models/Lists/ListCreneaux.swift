//
//  ListCreneaux.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation



class ListCreneauxVM: ObservableObject, CreneauVMObserver, IteratorProtocol {
    @Published var listOfCreneaux: [CreneauViewModel] = []
    private var index: Int?
    @Published var state: ListCreneauState = .ready {
        didSet{
            switch(state){
            case .deleteCreneau(at: let indexSet):
                self.delete(at: indexSet)
            case .moveCreneau(fromOffsets: let indexSet, toOffset: let index):
                self.move(fromOffsets: indexSet, toOffset: index)
            case .success(creneaux: let creneaux):
                self.listOfCreneaux = creneaux
            default:
                break
            }
        }
    }
    
    init(creneaux: [CreneauViewModel]){
        self.listOfCreneaux = creneaux
    }
    
    init() { }
    
    
    subscript(index: Int) -> CreneauViewModel{
        get{
            return self.listOfCreneaux[index]
        }
        set{
            self.listOfCreneaux[index] = newValue
        }
    }
    
    
    
    func updated(id: Int, model: CreneauViewModel) {
        for i in 0..<self.listOfCreneaux.count{
            if(self.listOfCreneaux[i].id == id){
                self.listOfCreneaux[i] = model
            }
        }
    }
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        self.listOfCreneaux.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
        
        
    public func delete(at: IndexSet){
        self.listOfCreneaux.remove(atOffsets: at)
    }
    
    
    private func nextIndex(for index: Int?) -> Int? {
            if let index = index, index < self.listOfCreneaux.count - 1 {
                return index + 1
            }
            if index == nil, !self.listOfCreneaux.isEmpty {
                return 0
            }
            return nil
        }
        
        func next() -> CreneauViewModel? {
            if let index = self.nextIndex(for: self.index) {
                self.index = index
                return self.listOfCreneaux[index]
            }
            return nil
        }
    
}




enum ListCreneauState: Equatable{
    case ready
    case loading
    case deleteCreneau(at: IndexSet)
    case moveCreneau(fromOffsets: IndexSet, toOffset: Int)
    case error
    case success(creneaux: [CreneauViewModel])
    
    
    static func == (lhs: ListCreneauState, rhs: ListCreneauState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.deleteCreneau(at: _), .deleteCreneau(at: _)):
            return true
        case (.ready, .ready):
            return true
        case (.moveCreneau(fromOffsets: _, toOffset: _), .moveCreneau(fromOffsets: _, toOffset: _)):
            return true
        case (.error, .error):
            return true
        case (.success(_), .success(_)):
            return true
        default:
            return false
        }
    }
}

