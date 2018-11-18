//
//  TurnActionSplashShoot.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 05/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class TurnActionSplashShoot: TurnActionDamage {
    private let map: HxMap
    
    let iconName = "power1"
    let turnSlots = GameBalance.shared.splashShootSlots
    
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
            return GameBalance.shared.lianaSplashDamage
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
