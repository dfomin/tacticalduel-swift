//
//  WeaponComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 09/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class WeaponComponent: GKComponent {
    
    private let cooldown: TimeInterval
    private(set) var damage: Int
    private(set) var rechargeTime = TimeInterval(0)
    
    var canShoot: Bool {
        return self.rechargeTime <= 0
    }
    
    init(damage: Int, cooldown: TimeInterval) {
        self.damage = damage
        self.cooldown = cooldown
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if rechargeTime > 0 {
            rechargeTime -= seconds
        }
    }
    
    func shoot() {
        self.rechargeTime = self.cooldown
    }
}
