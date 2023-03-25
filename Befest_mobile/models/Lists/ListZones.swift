//
//  ListZones.swift
//  Befest_mobile
//
//  Created by etud on 24/03/2023.
//

import Foundation


class ListZoneVM: ZoneVMObserver, ObservableObject, IteratorProtocol{
    @Published var listOfZones: [ZoneViewModel] = []
    private var index: Int?
    
    @Published var state: ListZonesState = .ready {
        didSet{
            switch state{
            case .moveZone(fromOffsets: let indexSet, toOffset: let index):
                self.move(fromOffsets: indexSet, toOffset: index)
            case .deleteZone(at: let indexSet):
                self.delete(at: indexSet)
            case .success(zones: let zones):
                self.listOfZones = zones
            default:
                break
            }
        }
    }
    
    
    subscript(index: Int) -> ZoneViewModel{
        get{
            return self.listOfZones[index]
        }
        set{
            self.listOfZones[index] = newValue
        }
    }
    
    
    
    public func updated(id: Int, model: ZoneViewModel) {
        for i in 0..<self.listOfZones.count{
            if(self.listOfZones[i].id == id){
                self.listOfZones[i] = model
            }
        }
    }
    
    
    
    
    
    public func move(fromOffsets: IndexSet, toOffset: Int){
        self.listOfZones.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
        
        
    public func delete(at: IndexSet){
        self.listOfZones.remove(atOffsets: at)
    }
    
    
    private func nextIndex(for index: Int?) -> Int? {
        if let index = index, index < self.listOfZones.count - 1 {
            return index + 1
        }
        if index == nil, !self.listOfZones.isEmpty {
            return 0
        }
        return nil
    }
    
    func next() -> ZoneViewModel? {
        if let index = self.nextIndex(for: self.index) {
            self.index = index
            return self.listOfZones[index]
        }
        return nil
    }
}




enum ListZonesState: Equatable{
    case ready
    case error
    case success(zones: [ZoneViewModel])
    case loading
    case deleteZone(at: IndexSet)
    case moveZone(fromOffsets: IndexSet, toOffset: Int)
    
    static func == (lhs: ListZonesState, rhs: ListZonesState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.deleteZone(at: _), .deleteZone(at: _)):
            return true
        case (.ready, .ready):
            return true
        case (.moveZone(fromOffsets: _, toOffset: _), .moveZone(fromOffsets: _, toOffset: _)):
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
