//
//  TurnActionAllDirectionsShoot.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 05/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class TurnActionAllDirectionsShoot: TurnActionDamage {
    private let map: HxMap
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        var area = [HxCoordinates]()
        for direction in HxDirection.allCases {
            area.append(contentsOf: map.straightPath(from: target, to: direction))
        }
        return area
    }
    
    var iconName: String {
        return "power2"
    }
    
    init(target: HxCoordinates, on map: HxMap) {
        self.target = target
        self.map = map
    }
    
    func damage(at coordinates: HxCoordinates) -> Int {
        if targetArea.contains(coordinates) {
            return GameBalance.shared.allDirectionsDamage
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
