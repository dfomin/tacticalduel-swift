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
    var selectedCharacter: Character? {
        didSet {
            updateActions()
            
            if let oldCoordinates = oldValue?.coordinates {
                mapView.set(color: .clear, for: oldCoordinates)
            }
            
            if let coordinates = selectedCharacter?.coordinates {
                mapView.set(color: .red, for: coordinates)
            }
        }
    }
    
    var currentAction: TurnActionTarget? {
        didSet {
            if let coordinates = currentAction?.target {
                mapView.set(color: .yellow, for: coordinates)
            } else {
                if let oldCoordinates = oldValue?.target {
                    if oldCoordinates != selectedCharacter?.coordinates {
                        mapView.set(color: .clear, for: oldCoordinates)
                    } else {
                        mapView.set(color: .red, for: oldCoordinates)
                    }
                }
            }
        }
    }
    
    let actionsNode = SKNode()
    let processButton = SKSpriteNode(imageNamed: "skip")

    override func sceneDidLoad() {
        let radius = 3
        let edge = frame.width / CGFloat((2 * radius + 1) + (radius + 1))
        mapView = HxMapView(radius: radius, edge: edge, center: CGPoint(x: frame.width / 2, y: frame.height / 2))
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
        let coordinates = mapView.coordinates(at: point)
        if mapView.map.isInside(coordinates: coordinates) {
            if var targetAction = currentAction {
                if selectedCharacter?.coordinates != targetAction.target {
                    mapView.set(color: .clear, for: targetAction.target)
                } else {
                    mapView.set(color: .red, for: targetAction.target)
                }
                targetAction.target = coordinates
                mapView.set(color: .yellow, for: coordinates)
            } else if let characterAtCell = mapView.map.cell(at: coordinates)?.mapObjects.first as? Character {
                selectedCharacter = characterAtCell
            } else {
                selectedCharacter = nil
            }
        } else if let character = selectedCharacter {
            var buttonTapped = false
            for button in buttons {
                if button.contains(location) {
                    if let index = buttons.index(of: button) {
                        turns[character.name]!.append(action: createAction(index: index))
                        updateActions()
                        
                        buttonTapped = true
                    }
                }
            }
            
            for (i, actionSprite) in actionsNode.children.enumerated() {
                if actionSprite.contains(touch.location(in: actionsNode)) {
                    turns[character.name]!.actions[i] = nil
                    updateActions()
                    
                    buttonTapped = true
                }
            }
            
            if !buttonTapped {
                selectedCharacter = nil
                currentAction = nil
            }
        }
        
        if processButton.contains(location) {
            selectedCharacter = nil
            currentAction = nil
            
            processActions(i: 0)
        }
    }
    
    private func create(name: String, q: Int, r: Int, edge: CGFloat) -> CharacterView {
        let coordinates = HxCoordinates(q: q, r: r)
        let character = CharacterView(coordinates: coordinates, name: name, edge: edge)
        mapView.map.add(object: character.character, at: coordinates)
        mapView.add(objectView: character.node, for: character.name)
        return character
    }
    
    private func createAction(index: Int) -> TurnAction {
        currentAction = nil
        
        switch index {
        case 0:
            return TurnActionMove(direction: .oclock2, object: selectedCharacter!, on: mapView.map)
        case 1:
            return TurnActionMove(direction: .oclock4, object: selectedCharacter!, on: mapView.map)
        case 2:
            return TurnActionMove(direction: .oclock6, object: selectedCharacter!, on: mapView.map)
        case 3:
            return TurnActionMove(direction: .oclock8, object: selectedCharacter!, on: mapView.map)
        case 4:
            return TurnActionMove(direction: .oclock10, object: selectedCharacter!, on: mapView.map)
        case 5:
            return TurnActionMove(direction: .oclock12, object: selectedCharacter!, on: mapView.map)
        case 6:
            let action = TurnActionCommonShoot(target: HxCoordinates(q: 0, r: 0), on: mapView.map)
            currentAction = action
            return action
        case 7:
            let action = power(number: 1, for: selectedCharacter!)
            if let targetAction = action as? TurnActionTarget {
                currentAction = targetAction
            }
            return action
        case 8:
            let action = power(number: 2, for: selectedCharacter!)
            if let targetAction = action as? TurnActionTarget {
                currentAction = targetAction
            }
            return action
        case 9:
            return TurnActionSkip()
        default:
            assert(false)
            return TurnActionSkip()
        }
    }
    
    private func power(number: Int, for character: Character) -> TurnAction {
        if character.name == "night" {
            if number == 1 {
                return TurnActionPoison(target: HxCoordinates(0, 0), on: mapView.map)
            } else if number == 2 {
                return TurnActionInvisibility(object: character)
            }
        } else if character.name == "fire" {
            if number == 1 {
                return TurnActionFireSection(source: { character.coordinates }, target: HxCoordinates(0, 0), on: mapView.map)
            } else if number == 2 {
                return TurnActionFireTrap(on: mapView.map)
            }
        } else if character.name == "water" {
            if number == 1 {
                return TurnActionOneDirectionShoot(source: { character.coordinates }, target: HxCoordinates(0, 0), on: mapView.map)
            } else if number == 2 {
                return TurnActionFreeze(target: HxCoordinates(0, 0), on: mapView.map)
            }
        } else if character.name == "stone" {
            if number == 1 {
                return TurnActionThrowStone(target: HxCoordinates(0, 0), on: mapView.map)
            } else if number == 2 {
                return TurnActionAllDirectionsShoot(source: { character.coordinates }, on: mapView.map)
            }
        } else if character.name == "ent" {
            if number == 1 {
                return TurnActionSplashShoot(target: HxCoordinates(0, 0), on: mapView.map)
            } else if number == 2 {
                return TurnActionHeal(object: character)
            }
        } else if character.name == "weather" {
            if number == 1 {
                return TurnActionLightning(target: HxCoordinates(0, 0), on: mapView.map)
            } else if number == 2 {
                return TurnActionBlow(target: HxCoordinates(0, 0), on: mapView.map)
            }
        }
        
        return TurnActionSkip()
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
    
    private func processActions(i: Int) {
        guard i < 3 else {
            for character in characters {
                turns[character.name] = CharacterTurn(numberOfActions: 3)
            }
            
            updateActions()
            
            return
        }
        
        var names = characters.map { $0.name }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let fireTrapAction = actions[i] as? TurnActionFireTrap {
                fireTrapAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let healAction = actions[i] as? TurnActionHeal {
                healAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let moveAction = actions[i] as? TurnActionMove {
                moveAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let blowAction = actions[i] as? TurnActionBlow {
                blowAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let poisonAction = actions[i] as? TurnActionPoison {
                poisonAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for r in -mapView.map.radius ... mapView.map.radius {
            for q in -mapView.map.radius ... mapView.map.radius {
                let coordinates = HxCoordinates(q, r)
                if let cell = mapView.map.cell(at: coordinates) {
                    if !cell.mapObjects.filter({ $0 is Mortal }).isEmpty {
                        for object in cell.mapObjects {
                            if let activatable = object as? Activatable {
                                activatable.activate()
                            }
                        }
                    }
                }
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let shootAction = actions[i] as? TurnActionAllDirectionsShoot {
                shootAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let shootAction = actions[i] as? TurnActionDamage {
                shootAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let freezeAction = actions[i] as? TurnActionFreeze {
                freezeAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for (name, actions) in turns {
            guard let character = characters.first(where: { $0.character.name == name })?.character, !character.isFreezed else {
                continue
            }
            
            if let invisibilityAction = actions[i] as? TurnActionInvisibility {
                invisibilityAction.doAction()
                
                names.removeAll(where: { $0 == name })
            }
        }
        
        for character in characters {
            if names.contains(character.name) {
                mapView.wait(objectView: character)
            }
        }
        
        for r in -mapView.map.radius ... mapView.map.radius {
            for q in -mapView.map.radius ... mapView.map.radius {
                let coordinates = HxCoordinates(q, r)
                if let cell = mapView.map.cell(at: coordinates) {
                    for object in cell.mapObjects {
                        if let temporary = object as? Temporary {
                            temporary.turnIsOver()
                        }
                    }
                }
            }
        }
        
        for character in characters {
            character.node.isHidden = character.character.isHidden
        }
        
        mapView.runActions(callback: { self.processActions(i: i + 1) })
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
