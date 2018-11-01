//
//  TurnActionSkip.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 22/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

class TurnActionSkip: TurnAction {
    var iconName: String {
        return "skip"
    }
    
    func doAction(on map: HxMap) {}
}
