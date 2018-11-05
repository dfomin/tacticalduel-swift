//
//  TurnActionThrowStone.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 05/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class TurnActionThrowStone: TurnActionDamage {
    private let map: HxMap
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        return [target]
    }
    
    var iconName: String {
        return "power1"
    }
    
    init(target: HxCoordinates, on map: HxMap) {
        self.target = target
        self.map = map
    }
    
    func damage(at coordinates: HxCoordinates) -> Int {
        if coordinates == target {
            return GameBalance.shared.throwStoneDamage
        } else {
            return 0
        }
    }
    
    func doAction() {
        guard let objects = map.cell(at: target)?.mapObjects else { return }
        
        for object in objects {
            if let mortal = object as? Mortal {
                mortal.apply(damage: damage(at: target))
            }
        }
    }
}
