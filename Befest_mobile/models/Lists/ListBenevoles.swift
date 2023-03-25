//
//  ListBenevoles.swift
//  Befest_mobile
//
//  Created by etud on 23/03/2023.
//

import Foundation


class BenevolesListVM: ObservableObject, BenevoleVMObserver, IteratorProtocol {
    @Published var listOfBenevoles: [UserViewModel] = []
    private var index: Int?
    @Published var state: ListBenevoleState = .ready {
        didSet{
            switch(state){
            case .deleteBenevole(at: let indexSet):
                self.delete(at: indexSet)
            case .moveBenevole(fromOffsets: let indexSet, toOffset: let index):
                self.move(fromOffsets: indexSet, toOffset: index)
            case .success(benevoles: let benevoles):
                self.listOfBenevoles = benevoles
            default:
                break
            }
        }
    }
    
    init(benevoles: [UserViewModel]){
        self.listOfBenevoles = benevoles
    }
    
    init() { }
    
    
    subscript(index: Int) -> UserViewModel{
        get{
            return self.listOfBenevoles[index]
        }
        set{
            self.listOfBenevoles[index] = newValue
        }
    }
    
    
    
    func updated(id: Int, model: UserViewModel) {
        for i in 0..<self.listOfBenevoles.count{
            if(self.listOfBenevoles[i].id == id){
                self.listOfBenevoles[i] = model
            }
        }
    }
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        self.listOfBenevoles.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
        
        
    public func delete(at: IndexSet){
        self.listOfBenevoles.remove(atOffsets: at)
    }
    
    
    private func nextIndex(for index: Int?) -> Int? {
            if let index = index, index < self.listOfBenevoles.count - 1 {
                return index + 1
            }
            if index == nil, !self.listOfBenevoles.isEmpty {
                return 0
            }
            return nil
        }
        
        func next() -> UserViewModel? {
            if let index = self.nextIndex(for: self.index) {
                self.index = index
                return self.listOfBenevoles[index]
            }
            return nil
        }
    
}




enum ListBenevoleState: Equatable{
    case ready
    case loading
    case deleteBenevole(at: IndexSet)
    case moveBenevole(fromOffsets: IndexSet, toOffset: Int)
    case error
    case success(benevoles: [UserViewModel])
    
    
    static func == (lhs: ListBenevoleState, rhs: ListBenevoleState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.deleteBenevole(at: _), .deleteBenevole(at: _)):
            return true
        case (.ready, .ready):
            return true
        case (.moveBenevole(fromOffsets: _, toOffset: _), .moveBenevole(fromOffsets: _, toOffset: _)):
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
