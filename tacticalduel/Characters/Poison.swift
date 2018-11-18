//
//  Poison.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 16/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class Poison: HxMapObject {
    private let map: HxMap
    
    var turnsLeft = GameBalance.shared.poisonTurnsCount
    
    init(coordinates: HxCoordinates, team: String, on map: HxMap) {
        self.map = map
        
        super.init(name: "Poison(\(coordinates.q),\(coordinates.r))", team: team, coordinates: coordinates)
    }
}

extension Poison: Activatable {
    func activate() {
        if let cell = map.cell(at: coordinates) {
            for object in cell.mapObjects {
                if let mortal = object as? Mortal {
                    mortal.apply(damage: GameBalance.shared.poisonDamage)
                }
            }
        }
    }
}

extension Poison: Temporary {
    func turnIsOver() {
        turnsLeft -= 1
        
        if turnsLeft <= 0 {
            map.remove(object: self, at: coordinates)
        }
    }
}
