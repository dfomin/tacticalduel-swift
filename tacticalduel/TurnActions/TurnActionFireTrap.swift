//
//  TurnActionFireTrap.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 16/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class TurnActionFireTrap: TurnAction {
    private let map: HxMap
    
    var iconName: String {
        return "power2"
    }
    
    init(on map: HxMap) {
        self.map = map
    }
    
    func doAction() {
        var freeCells = [HxCoordinates]()
        for r in -map.radius ... map.radius {
            for q in -map.radius ... map.radius {
                let coordinates = HxCoordinates(q, r)
                if let cell = map.cell(at: coordinates), cell.mapObjects.first(where: { $0 is Mortal || $0 is FireTrap }) == nil {
                    freeCells.append(coordinates)
                }
            }
        }
        
        var targetArea = [HxCoordinates]()
        var counter = GameBalance.shared.fireTrapCount
        while !freeCells.isEmpty && counter > 0 {
            let cell = freeCells.remove(at: Int.random(in: 0 ..< freeCells.count))
            targetArea.append(cell)
            counter -= 1
        }
        
        for target in targetArea {
            let fireTrap = FireTrap(coordinates: target, on: map)
            print(target.q, target.r)
            map.add(object: fireTrap, at: target)
        }
    }
}
