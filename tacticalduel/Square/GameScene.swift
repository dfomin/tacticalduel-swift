//
//  GameScene.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 02/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var entities = Set<GKEntity>()
    private var lastUpdateTimeInterval: TimeInterval!
    private var gridSize = (4, 8)
    
    override func sceneDidLoad() {
        var field = UIScreen.main.bounds
        let padding = (field.width - field.height / 2) / 2
        field = field.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        
        let playerUnit = PlayerUnit(name: "", field: field, gridSize: gridSize)
        self.entities.insert(playerUnit)
        let enemyUnit = AIUnit(name: "", field: field, gridSize: gridSize)
        self.entities.insert(enemyUnit)
        
        for entity in self.entities {
            let sprite = entity.component(ofType: SpriteComponent.self)!.node as! SKSpriteNode
            let spriteSize = entity.component(ofType: GridPositionComponent.self)!.spriteSize
            let label = entity.component(ofType: HealthViewComponent.self)!.label
            let node = entity.component(ofType: ScreenPositionComponent.self)!.node
            sprite.scale(to: spriteSize)
            node.addChild(sprite)
            node.addChild(label)
            addChild(node)
            
            updatePossibleMoves(entity: entity)
        }
        
        updateSpritePositions()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard self.lastUpdateTimeInterval != nil else {
            self.lastUpdateTimeInterval = currentTime
            return
        }
        
        let deltaTime = currentTime - self.lastUpdateTimeInterval
        self.lastUpdateTimeInterval = currentTime
        
        for entity in self.entities {
            entity.update(deltaTime: deltaTime)
            
            if let moveComponent = entity.component(ofType: RandomMoveComponent.self), let step = moveComponent.step {
                if let gridComponent = entity.component(ofType: GridPositionComponent.self) {
                    gridComponent.position = (gridComponent.position.0 + step.0, gridComponent.position.1 + step.1)
                    
                    updatePossibleMoves(entity: entity)
                }
            }
            
            if let weapon = entity.component(ofType: WeaponComponent.self), weapon.canShoot, Int.random(in: 0 ... 1) == 1 {
                weapon.shoot()
                let pos = entity.component(ofType: GridPositionComponent.self)!.position
                for targetEntity in self.entities {
                    let targetPos = targetEntity.component(ofType: GridPositionComponent.self)!.position!
                    let field1 = targetPos.1 / (gridSize.1 / 2)
                    let field2 = pos!.1 / (gridSize.1 / 2)
                    let isEnemy = field1 != field2
                    if (targetPos.0 == pos!.0) && isEnemy {
                        targetEntity.component(ofType: HealthComponent.self)!.apply(damage: weapon.damage)
                    }
                }
            }
        }
        
        updateSpritePositions()
        updateHealthViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
    }
}

extension GameScene {
    
    private func updateSpritePositions() {
        for entity in self.entities {
            if let gridPos = entity.component(ofType: GridPositionComponent.self),
                let node = entity.component(ofType: ScreenPositionComponent.self)?.node {
                node.position = gridPos.spritePosition
            }
        }
    }
    
    private func updatePossibleMoves(entity: GKEntity) {
        if let gridComponent = entity.component(ofType: GridPositionComponent.self),
            let moveComponent = entity.component(ofType: RandomMoveComponent.self) {
            var possibleMoves = [(Int, Int)]()
            
            if gridComponent.position.0 > 0 {
                possibleMoves.append((-1, 0))
            }
            
            if gridComponent.position.0 < self.gridSize.0 - 1 {
                possibleMoves.append((1, 0))
            }
            
            if gridComponent.position.1 % (self.gridSize.1 / 2) > 0 {
                possibleMoves.append((0, -1))
            }
            
            if gridComponent.position.1 % (self.gridSize.1 / 2) < (self.gridSize.1 / 2) - 1 {
                possibleMoves.append((0, 1))
            }
            
            moveComponent.possibleMoves = possibleMoves
            moveComponent.step = nil
        }
    }
    
    private func updateHealthViews() {
        for entity in self.entities {
            if let healthView = entity.component(ofType: HealthViewComponent.self),
                let health = entity.component(ofType: HealthComponent.self) {
                healthView.health = health.health
            }
        }
    }
}
