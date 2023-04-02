//
//  ListAffectations.swift
//  Befest_mobile
//
//  Created by m1 on 02/04/2023.
//

import Foundation


class ListAffectationsVM: ObservableObject, AffectationVMObserver, IteratorProtocol {
    @Published var listOfAffectations: [AffectationViewModel] = []
    private var index: Int?
    @Published var state: ListAffectationState = .ready {
        didSet{
            switch(state){
            case .deleteAffectation(at: let indexSet):
                self.delete(at: indexSet)
            case .moveAffectation(fromOffsets: let indexSet, toOffset: let index):
                self.move(fromOffsets: indexSet, toOffset: index)
            case .success(affectations: let affectations):
                self.listOfAffectations = affectations
            default:
                break
            }
        }
    }
    
    init(affectations: [AffectationViewModel]){
        self.listOfAffectations = affectations
    }
    
    init() { }
    
    
    subscript(index: Int) -> AffectationViewModel{
        get{
            return self.listOfAffectations[index]
        }
        set{
            self.listOfAffectations[index] = newValue
        }
    }
    
    
    
    func updated(id: Int, model: AffectationViewModel) {
        for i in 0..<self.listOfAffectations.count{
            if(self.listOfAffectations[i].id == id){
                self.listOfAffectations[i] = model
            }
        }
    }
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        self.listOfAffectations.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
        
        
    public func delete(at: IndexSet){
        self.listOfAffectations.remove(atOffsets: at)
    }
    
    
    private func nextIndex(for index: Int?) -> Int? {
            if let index = index, index < self.listOfAffectations.count - 1 {
                return index + 1
            }
            if index == nil, !self.listOfAffectations.isEmpty {
                return 0
            }
            return nil
        }
        
        func next() -> AffectationViewModel? {
            if let index = self.nextIndex(for: self.index) {
                self.index = index
                return self.listOfAffectations[index]
            }
            return nil
        }
    
}




enum ListAffectationState: Equatable{
    case ready
    case loading
    case deleteAffectation(at: IndexSet)
    case moveAffectation(fromOffsets: IndexSet, toOffset: Int)
    case error
    case success(affectations: [AffectationViewModel])
    
    
    static func == (lhs: ListAffectationState, rhs: ListAffectationState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.deleteAffectation(at: _), .deleteAffectation(at: _)):
            return true
        case (.ready, .ready):
            return true
        case (.moveAffectation(fromOffsets: _, toOffset: _), .moveAffectation(fromOffsets: _, toOffset: _)):
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

