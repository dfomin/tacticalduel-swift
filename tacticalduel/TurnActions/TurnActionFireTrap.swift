//
//  ActionFireTrap.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 16/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class ActionFireTrap: Action {
    private let map: HxMap
    private let team: String
    
    let iconName = "power2"
    let turnSlots = GameBalance.shared.fireTrapSlots
    
    init(team: String, on map: HxMap) {
        self.team = team
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
            let fireTrap = FireTrap(coordinates: target, team: team, on: map)
            map.add(object: fireTrap, at: target)
        }
    }
}
