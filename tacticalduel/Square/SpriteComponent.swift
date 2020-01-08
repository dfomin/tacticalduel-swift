//
//  SpriteComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 08/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class SpriteComponent: GKComponent {
    
    private(set) var node: SKNode
    
    init(color: UIColor, size: CGSize) {
        node = SKSpriteNode(color: color, size: size)
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
