//
//  Character.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 14/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class Character: Movable {
    private(set) var coordinates: HxCoordinates
    private let map: HxMap
    
    init(coordinates: HxCoordinates, map: HxMap) {
        self.coordinates = coordinates
        self.map = map
    }
    
    func step(direction: HxDirection) {
        let newCoordinates = self.coordinates + direction.relativeCoordinates
        if map.isInside(coordinates: newCoordinates) {
            self.coordinates = newCoordinates
        }
    }
}
