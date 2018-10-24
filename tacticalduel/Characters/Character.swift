//
//  Character.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 14/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class Character: HxMapObject {
    private(set) var coordinates: HxCoordinates
    
    var health: Int
    var maxHealth: Int
    
    init(coordinates: HxCoordinates, health: Int) {
        self.coordinates = coordinates
        self.health = health
        self.maxHealth = health
    }
}

extension Character: Movable {
    func step(direction: HxDirection) {
        self.coordinates = self.coordinates + direction.relativeCoordinates
    }
}

extension Character: Mortal {
    func apply(damage: Int) {
        health -= damage
        print(health)
    }
}
