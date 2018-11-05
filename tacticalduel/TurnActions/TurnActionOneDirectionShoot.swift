//
//  TurnActionOneDirectionShoot.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 06/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class TurnActionOneDirectionShoot: TurnActionDamage {
    private let map: HxMap
    private let source: HxCoordinates
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        var diff = target - source
        diff = HxCoordinates(diff.q != 0 ? diff.q / abs(diff.q) : 0, diff.r != 0 ? diff.r / abs(diff.r) : 0)
        let direction = HxDirection(coordinates: diff)!
        return map.straightPath(from: source, to: direction)
    }
    
    var iconName: String {
        return "power1"
    }
    
    init(source: HxCoordinates, target: HxCoordinates, on map: HxMap) {
        self.source = source
        self.target = target
        self.map = map
    }
    
    func damage(at coordinates: HxCoordinates) -> Int {
        if targetArea.contains(coordinates) {
            return GameBalance.shared.oneDirectionDamage
        } else {
            return 0
        }
    }
    
    func doAction() {
        for cell in targetArea {
            guard let objects = map.cell(at: cell)?.mapObjects else { continue }
            
            for object in objects {
                if let mortal = object as? Mortal {
                    mortal.apply(damage: damage(at: cell))
                }
            }
        }
    }
}
