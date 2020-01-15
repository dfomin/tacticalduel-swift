//
//  ActionLightning.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 05/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class ActionLightning: ActionDamage {
    private let map: HxMap
    
    let iconName = "power1"
    let turnSlots = GameBalance.shared.lightningSlots
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        var area = [target]
        area.append(contentsOf: map.neighbors(of: target))
        return area
    }
    
    init(target: HxCoordinates, on map: HxMap) {
        self.target = target
        self.map = map
    }
    
    func damage(at coordinates: HxCoordinates) -> Int {
        if distance(target, coordinates) <= 1 {
            return GameBalance.shared.lightningDamage
        } else {
            return 0
        }
    }
    
    func doAction() {
        var initialArea = targetArea
        var resultArea = [HxCoordinates]()
        while resultArea.count < 3 && !initialArea.isEmpty {
            resultArea.append(initialArea.remove(at: Int.random(in: 0 ..< initialArea.count)))
        }
        
        for cell in resultArea {
            guard let objects = map.cell(at: cell)?.mapObjects else { continue }
            
            for object in objects {
                if let mortal = object as? Mortal {
                    mortal.apply(damage: damage(at: cell))
                }
            }
        }
    }
}
