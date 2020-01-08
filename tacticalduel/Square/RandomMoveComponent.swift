//
//  RandomMoveComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 09/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class RandomMoveComponent: GKComponent {
    
    private static let cooldown = TimeInterval(0.5)
    
    private var timer = RandomMoveComponent.cooldown
    
    var possibleMoves = [(Int, Int)]()
    var step: (Int, Int)?
    
    override func update(deltaTime seconds: TimeInterval) {
        timer -= seconds
        if timer < 0 {
            doAction()
            self.timer += RandomMoveComponent.cooldown
        }
    }
    
    private func doAction() {
        step = possibleMoves.randomElement()
    }
}
