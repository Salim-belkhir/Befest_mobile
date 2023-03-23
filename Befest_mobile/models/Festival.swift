//
//  Festival.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import Combine


//DTO to use to communicate Data with the API
struct FestivalDTO: Decodable, Encodable{
    static func decodeFestival(data: [FestivalDTO]) -> [FestivalViewModel]?{
        var festivals = [FestivalViewModel]()
        for tdata in data{
            guard(tdata.id != 0) else{
                return nil
            }
            let festival = FestivalViewModel(id: tdata.id, name: tdata.name, year: tdata.year, nbOfDays: tdata.nbOfDays, closed: tdata.closed, numberOfBenevoles: tdata.countBenevoles)
            festivals.append(festival)
        }
        return festivals
    }
    
    var id: Int
    var name: String
    var year: String
    var nbOfDays: Int
    var closed: Bool
    var countBenevoles: Int
}


//The ViewModel
class FestivalViewModel: Equatable, ObservableObject{
    public var id: Int
    @Published var name: String
    @Published var year: String
    @Published var nbOfDays: Int
    @Published var closed: Bool
    public var numberOfBenevoles: Int
    @Published var state: FestivalState = .ready {
        didSet{
            switch state{
            case .closingFestival:
                self.closed = true
                notifyAll()
            case .success(let festival):
                self.name = festival.name
                self.id = festival.id
                self.year = festival.year
                notifyAll()
            default:
                break
            }
        }
    }
    
    private var observers : [ViewModelObserver] = []
    
    init(id: Int, name: String, year: String, nbOfDays: Int, closed: Bool, numberOfBenevoles: Int) {
        self.id = id
        self.name = name
        self.year = year
        self.nbOfDays = nbOfDays
        self.closed = closed
        self.numberOfBenevoles = numberOfBenevoles
    }
    
    static func == (lhs: FestivalViewModel, rhs: FestivalViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    func notifyAll(){
        for o in self.observers{
            o.updated(id: self.id, model: self)
        }
    }
}



enum FestivalState: Equatable{
    static func == (lhs: FestivalState, rhs: FestivalState) -> Bool {
        switch(lhs, rhs){
        case (.loading, .loading):
            return true
        case (.closingFestival, .closingFestival):
            return true
        case (.ready, .ready):
            return true
        case (.update, .update):
            return true
        case (.error, .error):
            return true
        case (.success(_), .success(_)):
            return true
        default:
            return false
        }
    }
    
    case loading
    case success(FestivalDTO)
    case closingFestival
    case ready
    case update
    case error
}
