//
//  ActionPoison.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 16/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class ActionPoison: ActionTarget {
    private let map: HxMap
    private let team: String
    
    let iconName = "power1"
    let turnSlots = GameBalance.shared.poisonSlots
    
    var target: HxCoordinates
    
    var targetArea: [HxCoordinates] {
        var area = [target]
        area.append(contentsOf: map.neighbors(of: target))
        return area
    }
    
    init(target: HxCoordinates, team: String, on map: HxMap) {
        self.target = target
        self.team = team
        self.map = map
    }
    
    func doAction() {
        for coordinates in targetArea {
            let poisonCell = Poison(coordinates: coordinates, team: team, on: map)
            map.add(object: poisonCell, at: coordinates)
        }
    }
}

