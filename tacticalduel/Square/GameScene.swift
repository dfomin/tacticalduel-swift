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
    
    private let actionTime = TimeInterval(0.5)
    
    private var lastUpdateTimeInterval: TimeInterval!
    private var gridSize = (4, 8)
    
    private var playerUnit: PlayerUnit!
    private var enemyUnit: AIUnit!
    
    private var units: [GKEntity] {
        return [playerUnit, enemyUnit]
    }
    
    private var actions = [GKEntity: [Action]]()
    private var futurePosition: (Int, Int)?
    private var actionIndex = 0
    private var actionTimer = TimeInterval(0)
    private var actionsInProgress = false
    
    private var gridScreenManager: GridScreenManager!
    
    override func sceneDidLoad() {
        var field = UIScreen.main.bounds
        let padding = (field.width - field.height / 2) / 2
        field = field.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        
        gridScreenManager = GridScreenManager(field: field, gridSize: gridSize)
        let positions = [(0, 0), (3, 7)]
        
        playerUnit = PlayerUnit(name: "", field: field, gridSize: gridSize)
        enemyUnit = AIUnit(name: "", field: field, gridSize: gridSize)
        
        for (i, entity) in self.units.enumerated() {
            let sprite = entity.component(ofType: SpriteComponent.self)!.node as! SKSpriteNode
            let spriteSize = gridScreenManager.cellSize
            let label = entity.component(ofType: HealthViewComponent.self)!.label
            let node = entity.component(ofType: ScreenPositionComponent.self)!.node
            node.position = gridScreenManager.screenPosition(for: positions[i])
            sprite.scale(to: spriteSize)
            node.addChild(sprite)
            node.addChild(label)
            addChild(node)
        }
        
        actions[playerUnit] = [MoveAction(shift: (1, 0)), ShootAction(), MoveAction(shift: (1, 0))]
        actions[enemyUnit] = [MoveAction(shift: (-1, 0)), MoveAction(shift: (-1, 0)), ShootAction()]
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard self.lastUpdateTimeInterval != nil else {
            self.lastUpdateTimeInterval = currentTime
            return
        }
        
        if actionIndex == -1 || actionsInProgress {
            return
        }
        
        actionsInProgress = true
        
        let delayAction = SKAction.wait(forDuration: actionTime)
        self.run(delayAction) {
            self.actionIndex += 1
            self.actionsInProgress = false
            if self.actionIndex == 3 {
                self.actionIndex = -1
                for unit in self.units {
                    self.actions[unit] = []
                }
            }
        }
        
        for entity in self.units {
            if let action = actions[entity]?[actionIndex] {
                if let moveAction = action as? MoveAction {
                    let shift = moveAction.shift
                    let cellSize = gridScreenManager.cellSize.width
                    let delta = CGVector(dx: CGFloat(shift.0) * cellSize, dy: CGFloat(shift.1) * cellSize)
                    let entityAction = SKAction.move(by: delta, duration: actionTime)
                    entity.component(ofType: ScreenPositionComponent.self)!.node.run(entityAction)
                } else if action is ShootAction {
                    let entityAction = SKAction.wait(forDuration: actionTime)
                    let node = entity.component(ofType: ScreenPositionComponent.self)!.node
                    node.run(entityAction) {
                        let (x, _) = self.gridScreenManager.gridPosition(for: node.position)!
                        let enemy: GKEntity = entity == self.playerUnit ? self.enemyUnit : self.playerUnit
                        let enemyPosition = enemy.component(ofType: ScreenPositionComponent.self)!.node.position
                        let (enemyX, _) = self.gridScreenManager.gridPosition(for: enemyPosition)!
                        if x == enemyX {
                            let healthComponent = enemy.component(ofType: HealthComponent.self)!
                            healthComponent.apply(damage: 1)
                            enemy.component(ofType: HealthViewComponent.self)!.health = healthComponent.health
                        }
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard actionIndex == -1 && !actionsInProgress else { return }
        
        if let touch = touches.first {
            if let cell = gridScreenManager.gridPosition(for: touch.location(in: self)) {
                let spritePos = playerUnit.component(ofType: ScreenPositionComponent.self)!.node.position
                let futurePos = futurePosition ?? gridScreenManager.gridPosition(for: spritePos)!
                if futurePos == cell {
                    actions[playerUnit]!.append(ShootAction())
                } else {
                    let x = cell.0 - futurePos.0
                    let y = cell.1 - futurePos.1
                    if (x == 0 && abs(y) == 1) || (y == 0 && abs(x) == 1) {
                        actions[playerUnit]!.append(MoveAction(shift: (x, y)))
                        futurePosition = cell
                    }
                }
                
                if actions[playerUnit]!.count == 3 {
                    actionIndex = 0
                    actions[enemyUnit] = [MoveAction(shift: (-1, 0)), ShootAction(), MoveAction(shift: (1, 0))]
                }
            }
        }
    }
}

extension GameScene {
    
    private func updateHealthViews() {
        for entity in self.units {
            if let healthView = entity.component(ofType: HealthViewComponent.self),
                let health = entity.component(ofType: HealthComponent.self) {
                healthView.health = health.health
            }
        }
    }
}
