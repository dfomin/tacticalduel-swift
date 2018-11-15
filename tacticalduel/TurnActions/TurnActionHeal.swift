//
//  TurnActionHeal.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 15/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class TurnActionHeal: TurnAction {
    private let object: Mortal
    
    var iconName: String {
        return "power2"
    }
    
    init(object: Mortal) {
        self.object = object
    }
    
    func doAction() {
        object.apply(damage: -GameBalance.shared.heal)
    }
}
