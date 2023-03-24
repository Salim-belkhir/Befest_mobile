//
//  ListJours.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation


class ListJoursVM: JourVMObserver, ObservableObject, IteratorProtocol{
    @Published var listOfJours: [JourViewModel] = []
    private var index: Int?
    
    @Published var state: ListJoursState = .ready {
        didSet{
            switch state{
            case .moveJour(fromOffsets: let indexSet, toOffset: let index):
                self.move(fromOffsets: indexSet, toOffset: index)
            case .deleteJour(at: let indexSet):
                self.delete(at: indexSet)
            case .success(jours: let jours):
                self.listOfJours = jours
            default:
                break
            }
        }
    }
    
    
    subscript(index: Int) -> JourViewModel{
        get{
            return self.listOfJours[index]
        }
        set{
            self.listOfJours[index] = newValue
        }
    }
    
    
    
    public func updated(id: Int, model: JourViewModel) {
        for i in 0..<self.listOfJours.count{
            if(self.listOfJours[i].id == id){
                self.listOfJours[i] = model
            }
        }
    }
    
    
    
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        self.listOfJours.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
        
        
    public func delete(at: IndexSet){
        self.listOfJours.remove(atOffsets: at)
    }
    
    
    private func nextIndex(for index: Int?) -> Int? {
        if let index = index, index < self.listOfJours.count - 1 {
            return index + 1
        }
        if index == nil, !self.listOfJours.isEmpty {
            return 0
        }
        return nil
    }
    
    func next() -> JourViewModel? {
        if let index = self.nextIndex(for: self.index) {
            self.index = index
            return self.listOfJours[index]
        }
        return nil
    }
}


enum ListJoursState: Equatable{
    case ready
    case success(jours: [JourViewModel])
    case error
    case loading
    case deleteJour(at: IndexSet)
    case moveJour(fromOffsets: IndexSet, toOffset: Int)
    
    static func == (lhs: ListJoursState, rhs: ListJoursState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.deleteJour(at: _), .deleteJour(at: _)):
            return true
        case (.ready, .ready):
            return true
        case (.moveJour(fromOffsets: _, toOffset: _), .moveJour(fromOffsets: _, toOffset: _)):
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
