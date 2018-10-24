//
//  Movable.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 23/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

protocol Movable {
    var coordinates: HxCoordinates { get }
    
    func step(direction: HxDirection)
}
