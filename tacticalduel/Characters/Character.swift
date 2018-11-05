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
        
        delegate?.healthDidChange()
    }
}
