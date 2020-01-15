//
//  ActionHeal.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 15/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class ActionHeal: Action {
    private let object: Mortal
    
    let iconName = "power2"
    let turnSlots = GameBalance.shared.healSlots
    
    init(object: Mortal) {
        self.object = object
    }
    
    func doAction() {
        object.apply(damage: -GameBalance.shared.heal)
    }
}
