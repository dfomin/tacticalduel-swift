//
//  ScreenPositionComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 09/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit
import SpriteKit

class ScreenPositionComponent: GKComponent {
    
    private(set) var node: SKNode
    
    override init() {
        node = SKNode()
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
