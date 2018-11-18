//
//  TurnActionBlow.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 15/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class TurnActionBlow: TurnActionTarget {
    private let map: HxMap
    
    let iconName = "power2"
    let turnSlots = GameBalance.shared.blowSlots
    
    var target: HxCoordinates
    
    init(target: HxCoordinates, on map: HxMap) {
        self.target = target
        self.map = map
    }
    
    func doAction() {
        var targetArea = [HxCoordinates]()
        for r in -map.radius ... map.radius {
            for q in -map.radius ... map.radius {
                let coordinates = HxCoordinates(q, r)
                if map.isInside(coordinates: coordinates) {
                    targetArea.append(coordinates)
                }
            }
        }
        
        let directionCoordinates: HxCoordinates
        if let direction = HxDirection(coordinates: target) {
            directionCoordinates = direction.relativeCoordinates
        } else {
            directionCoordinates = HxCoordinates(1, -1)
        }
        
        targetArea.sort { (c1, c2) -> Bool in
            if directionCoordinates.q == 1 {
                return c1.q > c2.q
            } else if directionCoordinates.q == -1 {
                return c1.q < c2.q
            } else if directionCoordinates.r == 1 {
                return c1.r > c2.r
            } else if directionCoordinates.r == -1 {
                return c1.r < c2.r
            } else {
                return false
            }
        }
        
        for coordinates in targetArea {
            guard let object = map.cell(at: coordinates)?.mapObjects.filter({ $0 is Mortal }).first else {
                continue
            }
            
            let target = coordinates + directionCoordinates
            if let cell = map.cell(at: target) {
                if cell.mapObjects.isEmpty {
                    map.move(object: object, to: target)
                }
            }
        }
    }
}
