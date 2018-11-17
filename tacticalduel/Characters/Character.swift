//
//  Character.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 14/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

protocol CharacterDelegate: class {
    func healthDidChange()
}

class Character: HxMapObject {
    var health: Int
    var maxHealth: Int
    
    var freezeCount = 0
    
    weak var delegate: CharacterDelegate?
    
    init(name: String, coordinates: HxCoordinates, health: Int) {
        self.health = health
        self.maxHealth = health
        
        super.init(name: name, coordinates: coordinates)
    }
}

extension Character: Mortal {
    func apply(damage: Int) {
        health -= damage
        if health < 0 {
            health = 0
        } else if health > maxHealth {
            health = maxHealth
        }
        
        delegate?.healthDidChange()
    }
}

extension Character: Freezable {
    var turnsLeft: Int {
        return freezeCount
    }
    
    func turnIsOver() {
        freezeCount -= 1
    }
    
    func isFreezed() -> Bool {
        return freezeCount > 0
    }
    
    func freeze(turnsNumber: Int) {
        freezeCount = turnsNumber + 1
    }
}
