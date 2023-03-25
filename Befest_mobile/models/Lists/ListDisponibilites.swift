//
//  ListDisponibilites.swift
//  Befest_mobile
//
//  Created by m1 on 25/03/2023.
//

import Foundation


class ListDisponibilitesVM: ObservableObject, DisponibiliteVMObserver, IteratorProtocol {
    @Published var listOfDisponibilites: [DisponibiliteViewModel] = []
    private var index: Int?
    @Published var state: ListDispoState = .ready {
        didSet{
            switch(state){
            case .deleteDispo(at: let indexSet):
                self.delete(at: indexSet)
            case .moveDispo(fromOffsets: let indexSet, toOffset: let index):
                self.move(fromOffsets: indexSet, toOffset: index)
            case .success(dispos: let dispos):
                self.listOfDisponibilites = dispos
            default:
                break
            }
        }
    }
    
    init(dispos: [DisponibiliteViewModel]){
        self.listOfDisponibilites = dispos
    }
    
    init() { }
    
    
    subscript(index: Int) -> DisponibiliteViewModel{
        get{
            return self.listOfDisponibilites[index]
        }
        set{
            self.listOfDisponibilites[index] = newValue
        }
    }
    
    
    
    func updated(id: Int, model: DisponibiliteViewModel) {
        for i in 0..<self.listOfDisponibilites.count{
            if(self.listOfDisponibilites[i].id == id){
                self.listOfDisponibilites[i] = model
            }
        }
    }
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        self.listOfDisponibilites.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
        
        
    public func delete(at: IndexSet){
        self.listOfDisponibilites.remove(atOffsets: at)
    }
    
    
    private func nextIndex(for index: Int?) -> Int? {
            if let index = index, index < self.listOfDisponibilites.count - 1 {
                return index + 1
            }
            if index == nil, !self.listOfDisponibilites.isEmpty {
                return 0
            }
            return nil
        }
        
        func next() -> DisponibiliteViewModel? {
            if let index = self.nextIndex(for: self.index) {
                self.index = index
                return self.listOfDisponibilites[index]
            }
            return nil
        }
    
}




enum ListDispoState: Equatable{
    case ready
    case loading
    case deleteDispo(at: IndexSet)
    case moveDispo(fromOffsets: IndexSet, toOffset: Int)
    case error
    case success(dispos: [DisponibiliteViewModel])
    
    
    static func == (lhs: ListDispoState, rhs: ListDispoState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.deleteDispo(at: _), .deleteDispo(at: _)):
            return true
        case (.ready, .ready):
            return true
        case (.moveDispo(fromOffsets: _, toOffset: _), .moveDispo(fromOffsets: _, toOffset: _)):
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
