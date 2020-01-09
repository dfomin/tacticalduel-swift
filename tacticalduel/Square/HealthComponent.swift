//
//  HealthComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 09/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class HealthComponent: GKComponent {
    
    private let maxHealth: Int
    
    private(set) var health: Int
    
    init(health: Int) {
        self.maxHealth = health
        self.health = health
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(damage: Int) {
        self.health -= damage
    }
}
