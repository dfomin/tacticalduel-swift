//
//  TurnActionMove.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 21/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class TurnActionMove: TurnAction {
    var iconName: String {
        switch direction {
        case .oclock2:
            return "move2"
        case .oclock4:
            return "move4"
        case .oclock6:
            return "move6"
        case .oclock8:
            return "move8"
        case .oclock10:
            return "move10"
        case .oclock12:
            return "move12"
        }
    }
    
    let direction: HxDirection
    
    init(direction: HxDirection) {
        self.direction = direction
    }
}
