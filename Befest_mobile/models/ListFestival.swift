//
//  ListFestival.swift
//  Befest_mobile
//
//  Created by etud on 23/03/2023.
//

import Foundation



class FestivalListVM: ObservableObject, ViewModelObserver, IteratorProtocol {
    
    @Published var listOfFestivals : [FestivalViewModel] = []
    private var index: Int?
    @Published var state: ListFestivalState = .ready {
        didSet{
            switch state{
            case .deleteFestival(at: let indexSet):
                self.delete(at: indexSet)
            case .moveFestival(fromOffsets: let indexSet, toOffset: let index):
                self.move(fromOffsets: indexSet, toOffset: index)
            case .success(festivals: let festivals):
                self.listOfFestivals = festivals
            default:
                break
            }
        }
    }
    
    
    init(festivals: [FestivalViewModel]){
        self.listOfFestivals = festivals
    }
    
    init(){ }
    
    
    subscript(index: Int) -> FestivalViewModel{
        get{
            return self.listOfFestivals[index]
        }
        set{
            self.listOfFestivals[index] = newValue
        }
    }
    
    
    
    func updated(id: Int, model: FestivalViewModel) {
        for i in 0..<self.listOfFestivals.count{
            if(self.listOfFestivals[i].id == id){
                self.listOfFestivals[i] = model
            }
        }
    }
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        self.listOfFestivals.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
        
        
    public func delete(at: IndexSet){
        self.listOfFestivals.remove(atOffsets: at)
    }
    
    
    private func nextIndex(for index: Int?) -> Int? {
        if let index = index, index < self.listOfFestivals.count - 1 {
            return index + 1
        }
        if index == nil, !self.listOfFestivals.isEmpty {
            return 0
        }
        return nil
    }
    
    func next() -> FestivalViewModel? {
        if let index = self.nextIndex(for: self.index) {
            self.index = index
            return self.listOfFestivals[index]
        }
        return nil
    }
    
}



enum ListFestivalState: Equatable{
    case ready
    case loading
    case deleteFestival(at: IndexSet)
    case moveFestival(fromOffsets: IndexSet, toOffset: Int)
    case error
    case success(festivals: [FestivalViewModel])
    
    
    static func == (lhs: ListFestivalState, rhs: ListFestivalState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.deleteFestival(at: _), .deleteFestival(at: _)):
            return true
        case (.ready, .ready):
            return true
        case (.moveFestival(fromOffsets: _, toOffset: _), .moveFestival(fromOffsets: _, toOffset: _)):
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
