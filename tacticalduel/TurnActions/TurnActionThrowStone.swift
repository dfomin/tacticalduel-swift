//
//  ActionThrowStone.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 05/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class ActionThrowStone: ActionDamage {
    private let map: HxMap
    
    let iconName = "power1"
    let turnSlots = GameBalance.shared.throwStoneSlots
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        return [target]
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
