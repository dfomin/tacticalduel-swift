//
//  Character.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 14/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol CharacterDelegate: class {
    func healthDidChange()
}

class Character: HxMapObject {
    var health: Int
    var maxHealth: Int
    
    var freezeCount = 0
    var invisibleCount = 0
    
    weak var delegate: CharacterDelegate?
    
    init(name: String, team: String, coordinates: HxCoordinates, health: Int) {
        self.health = health
        self.maxHealth = health
        
        super.init(name: name, team: team, coordinates: coordinates)
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

extension Character: Temporary {
    var turnsLeft: Int {
        return freezeCount
    }
    
    func turnIsOver() {
        freezeCount -= 1
        invisibleCount -= 1
    }
}

extension Character: Freezable {
    var isFreezed: Bool {
        return freezeCount > 0
    }
    
    func freeze(turnsNumber: Int) {
        freezeCount = turnsNumber + 1
    }
}

extension Character: Invisible {
    var isHidden: Bool {
        return invisibleCount > 0
    }
    
    func hide(turnsNumber: Int) {
        invisibleCount = turnsNumber + 1
    }
}
