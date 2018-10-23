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
    var mapView: HxMapView!
    var characters = [CharacterView]()
    var buttons = [SKSpriteNode]()
    var turns = [String: CharacterTurn]()
    var selectedCharacter: CharacterView? {
        didSet {
            updateActions()
        }
    }
    
    let actionsNode = SKNode()
    let processButton = SKSpriteNode(imageNamed: "skip")

    override func sceneDidLoad() {
        let edge = frame.width / CGFloat(11)
        mapView = HxMapView(radius: 4, edge: edge, center: CGPoint(x: frame.width / 2, y: frame.height / 2))
        addChild(mapView.node)
        
        self.backgroundColor = .gray
        
        characters.append(create(name: "night", q: -3, r: 0, edge: edge))
        characters.append(create(name: "fire", q: -3, r: 3, edge: edge))
        characters.append(create(name: "water", q: 3, r: -3, edge: edge))
        characters.append(create(name: "stone", q: 3, r: 0, edge: edge))
        characters.append(create(name: "ent", q: 0, r: 3, edge: edge))
        characters.append(create(name: "weather", q: 0, r: -3, edge: edge))
        
        for character in characters {
            turns[character.name] = CharacterTurn(numberOfActions: 3)
        }
        
        let buttonNames = [
            "move2",
            "move4",
            "move6",
            "move8",
            "move10",
            "move12",
            "shoot",
            "power1",
            "power2",
            "skip"
        ]
        
        for (i, name) in buttonNames.enumerated() {
            let button = SKSpriteNode(imageNamed: name)
            button.anchorPoint = CGPoint(x: 0, y: 1)
            button.position = CGPoint(x: CGFloat(i % 5) * frame.width / CGFloat(buttonNames.count / 2) + button.frame.width / 2,
                                      y: frame.height - button.frame.height / 2 - button.frame.height * CGFloat(i / 5))
            buttons.append(button)
            addChild(button)
        }
        
        actionsNode.position = CGPoint(x: frame.width / 2, y: 0)
        addChild(actionsNode)
        
        processButton.anchorPoint = CGPoint(x: 0, y: 0)
        processButton.position = CGPoint(x: 0, y: 0)
        addChild(processButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let point = viewToMap(point: location)
        if let cell = mapView.cell(for: point) {
            let characterAtCell = characters.first(where: { $0.character.coordinates.q == cell.q && $0.character.coordinates.r == cell.r })
            if characterAtCell != nil {
                selectedCharacter = characterAtCell
            }
        } else if let character = selectedCharacter {
            for button in buttons {
                if button.contains(location) {
                    if let index = buttons.index(of: button) {
                        turns[character.name]!.append(action: createAction(index: index))
                        updateActions()
                    }
                }
            }
            
            for (i, actionSprite) in actionsNode.children.enumerated() {
                if actionSprite.contains(touch.location(in: actionsNode)) {
                    turns[character.name]!.actions[i] = nil
                    updateActions()
                }
            }
        }
        
        if processButton.contains(location) {
            processActions()
        }
    }
    
    private func create(name: String, q: Int, r: Int, edge: CGFloat) -> CharacterView {
        let character = CharacterView(coordinates: HxCoordinates(q: q, r: r), name: name, edge: edge, map: mapView.map)
        guard let cell = mapView.map.cells.first(where: { $0.q == q && $0.r == r }) else {
            assert(false)
            return character
        }
        
        let position = mapToView(point: mapView.point(for: cell))
        character.node.position = position
        
        addChild(character.node)
        
        return character
    }
    
    private func createAction(index: Int) -> TurnAction {
        switch index {
        case 0:
            return TurnActionMove(direction: .oclock2, object: selectedCharacter!.character)
        case 1:
            return TurnActionMove(direction: .oclock4, object: selectedCharacter!.character)
        case 2:
            return TurnActionMove(direction: .oclock6, object: selectedCharacter!.character)
        case 3:
            return TurnActionMove(direction: .oclock8, object: selectedCharacter!.character)
        case 4:
            return TurnActionMove(direction: .oclock10, object: selectedCharacter!.character)
        case 5:
             return TurnActionMove(direction: .oclock12, object: selectedCharacter!.character)
        case 6:
            return TurnActionShoot()
        case 7:
            return TurnActionPower()
        case 8:
            return TurnActionPower()
        case 9:
            return TurnActionSkip()
        default:
            assert(false)
            return TurnActionSkip()
        }
    }
    
    private func updateActions() {
        actionsNode.removeAllChildren()
        
        if let name = selectedCharacter?.name, let turn = turns[name] {
            for (i, action) in turn.actions.enumerated() {
                let sprite = SKSpriteNode(imageNamed: action?.iconName ?? "empty")
                sprite.anchorPoint = CGPoint(x: 0.5, y: 0)
                sprite.position = CGPoint(x: CGFloat(i - 1) * sprite.frame.width * 1.5, y: sprite.frame.height / 2)
                actionsNode.addChild(sprite)
            }
        }
    }
    
    private func processActions() {
        for character in characters {
            var actions = [SKAction]()
            for i in 0 ..< 3 {
                if let action = turns[character.name]?.actions[i] as? TurnActionMove {
                    action.doAction()
                    let q = character.character.coordinates.q
                    let r = character.character.coordinates.r
                    let cell = mapView.map.cells.first(where: { $0.q == q && $0.r == r })!
                    let newPosition = mapToView(point: mapView.point(for: cell))
                    let moveAction = SKAction.move(to: newPosition, duration: 0.3)
                    moveAction.timingMode = .easeIn
                    actions.append(moveAction)
                } else {
                    actions.append(SKAction.wait(forDuration: 0.3))
                }
            }
            
            character.node.run(SKAction.sequence(actions))
            
            turns[character.name] = CharacterTurn(numberOfActions: 3)
        }
        
        updateActions()
    }
    
    private func mapToView(point: CGPoint) -> CGPoint {
        var viewPoint = self.convert(point, from: mapView.node)
        viewPoint.y = frame.height - viewPoint.y
        return viewPoint
    }
    
    private func viewToMap(point: CGPoint) -> CGPoint {
        var point = point
        point.y = frame.height - point.y
        return self.convert(point, to: mapView.node)
    }
}
