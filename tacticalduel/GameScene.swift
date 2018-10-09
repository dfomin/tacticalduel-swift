//
//  GameScene.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 07/05/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import SpriteKit
import GameplayKit
import Hexamap

class GameScene: SKScene {
    let map = HxMap(radius: 4)

    override func sceneDidLoad() {
        print("\(map.radius)")
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
