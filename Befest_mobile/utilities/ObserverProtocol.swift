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


protocol JourVMObserver{
    func updated(id: Int, model: JourViewModel)
}


protocol ZoneVMObserver{
    func updated(id: Int, model: ZoneViewModel)
}



protocol CreneauVMObserver{
    func updated(id: Int, model: CreneauViewModel)
}


protocol AffectationVMObserver{
    func updated(id: Int, model: AffectationViewModel)
}


protocol DisponibiliteVMObserver{
    func updated(id: Int, model: DisponibiliteViewModel)
}
