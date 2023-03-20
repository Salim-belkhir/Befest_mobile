//
//  Festival.swift
//  Befest_mobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import Combine


struct FestivalDTO: Decodable, Encodable{
    static func decodeFestival(data: [FestivalDTO]) -> [FestivalViewModel]?{
        var festivals = [FestivalViewModel]()
        for tdata in data{
            guard(tdata.id != "") else{
                return nil
            }
            let festival = FestivalViewModel(id: tdata.id, name: tdata.name, year: tdata.year, nbOfDays: tdata.nbOfDays, closed: tdata.closed, numberOfBenevoles: tdata.countBenevoles)
            festivals.append(festival)
        }
        return festivals
    }
    
    var id: String
    var name: String
    var year: String
    var nbOfDays: Int
    var closed: Bool
    var countBenevoles: Int
}


class FestivalViewModel: Equatable, ObservableObject{
    public var id: String
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
            default:
                break
            }
        }
    }
    
    init(id: String, name: String, year: String, nbOfDays: Int, closed: Bool, numberOfBenevoles: Int) {
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
}



enum FestivalState{
    case loading
    case success(FestivalDTO)
    case closingFestival
    case ready
    case update
    case error
}
