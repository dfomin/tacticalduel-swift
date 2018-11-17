//
//  TurnActionFreeze.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 17/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class TurnActionFreeze: TurnActionTarget {
    private let map: HxMap
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        var area = [target]
        area.append(contentsOf: map.neighbors(of: target))
        return area
    }
    
    var iconName: String {
        return "power2"
    }
    
    init(target: HxCoordinates, on map: HxMap) {
        self.target = target
        self.map = map
    }
    
    func doAction() {
        for cell in targetArea {
            guard let objects = map.cell(at: cell)?.mapObjects else { continue }
            
            for object in objects {
                if let freezable = object as? Freezable {
                    freezable.freeze(turnsNumber: GameBalance.shared.freezeTurnsNumber)
                }
            }
        }
    }
}
