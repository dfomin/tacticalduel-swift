//
//  HxMapObjectView.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 24/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import SpriteKit

protocol HxMapObjectView {
    var mapObject: HxMapObject { get }
    var node: SKNode { get }
}
