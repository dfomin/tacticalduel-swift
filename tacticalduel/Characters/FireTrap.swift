//
//  FireTrap.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 16/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class FireTrap: HxMapObject {
    private let map: HxMap
    
    init(coordinates: HxCoordinates, on map: HxMap) {
        self.map = map
        
        super.init(name: "FireTrap(\(coordinates.q),\(coordinates.r))", coordinates: coordinates)
    }
}

extension FireTrap: Activatable {
    func activate() {
        if let cell = map.cell(at: coordinates) {
            for object in cell.mapObjects {
                if let mortal = object as? Mortal {
                    mortal.apply(damage: GameBalance.shared.fireTrapDamage)
                }
            }
        }
        
        map.remove(object: self, at: coordinates)
    }
}
