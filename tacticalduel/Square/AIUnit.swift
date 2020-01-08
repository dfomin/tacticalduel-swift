//
//  AIUnit.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 09/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class AIUnit: GKEntity {
    init(name: String, field: CGRect, gridSize: (Int, Int)) {
        super.init()
        
        addComponent(SpriteComponent(color: .red, size: CGSize(width: 100, height: 100)))
        addComponent(GridPositionComponent(field: field, gridSize: gridSize, initialPosition: (3, 7)))
        addComponent(RandomMoveComponent())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
