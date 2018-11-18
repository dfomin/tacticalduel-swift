//
//  TurnActionFireSection.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 05/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class TurnActionFireSection: TurnActionDamage {
    private let map: HxMap
    private let source: () -> HxCoordinates
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        var area = map.section(from: source(), to: target, length: GameBalance.shared.fireSectionLength)
        area.removeAll(where: { $0 == source() })
        return area
    }
    
    var iconName: String {
        return "power1"
    }
    
    init(source: @escaping () -> HxCoordinates, target: HxCoordinates, on map: HxMap) {
        self.source = source
        self.target = target
        self.map = map
    }
    
    func damage(at coordinates: HxCoordinates) -> Int {
        if targetArea.contains(coordinates) {
            return GameBalance.shared.fireSectionDamage
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
