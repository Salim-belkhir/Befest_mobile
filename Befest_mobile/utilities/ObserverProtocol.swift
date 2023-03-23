//
//  ObservableObserverProtocol.swift
//  Befest_mobile
//
//  Created by etud on 23/03/2023.
//

import Foundation


protocol ViewModelObserver{
    func updated(id: Int, model: FestivalViewModel)
}


protocol BenevoleVMObserver{
    func updated(id: Int, model: UserViewModel)
}
