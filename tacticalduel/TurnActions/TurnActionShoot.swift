//
//  TurnActionShoot.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 21/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class TurnActionShoot: TurnAction {
    let damage: Int
    let target: HxCell
    
    var iconName: String {
        return "shoot"
    }
    
    init(damage: Int, target: HxCell) {
        self.damage = damage
        self.target = target
    }
    
    func doAction() {
        for object in target.mapObjects {
            if let mortal = object as? Mortal {
                mortal.apply(damage: damage)
            }
        }
    }
}
