//
//  PlayerUnit.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 08/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class PlayerUnit: GKEntity {
    
    init(name: String, field: CGRect, gridSize: (Int, Int)) {
        super.init()
        
        addComponent(ScreenPositionComponent())
        addComponent(SpriteComponent(color: .green, size: CGSize(width: 100, height: 100)))
        addComponent(HealthComponent(health: 5))
        addComponent(HealthViewComponent(health: 5))
        addComponent(WeaponComponent(damage: 1, cooldown: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
