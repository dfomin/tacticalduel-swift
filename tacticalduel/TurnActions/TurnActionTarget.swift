//
//  TurnActionTarget.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 01/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

protocol TurnActionTarget: TurnAction {
    var target: HxCoordinates { get set }
    
    init(target: HxCoordinates)
}
