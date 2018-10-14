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
    var characters = [Character]()
    var selectedCharacter: Character?

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
            let characterAtCell = characters.first(where: { $0.q == cell.q && $0.r == cell.r })
            if characterAtCell != nil {
                selectedCharacter = characterAtCell
            } else if let character = selectedCharacter {
                character.setPosition(q: cell.q, r: cell.r)
                let newPosition = mapToView(point: mapView.point(for: cell))
                let moveAction = SKAction.move(to: newPosition, duration: 0.3)
                moveAction.timingMode = .easeIn
                character.node.run(moveAction)
            }
        }
    }
    
    private func create(name: String, q: Int, r: Int, edge: CGFloat) -> Character {
        let character = Character(q: q, r: r, name: name, edge: edge)
        guard let cell = mapView.map.cells.first(where: { $0.q == q && $0.r == r }) else {
            assert(false)
            return character
        }
        
        let position = mapToView(point: mapView.point(for: cell))
        character.node.position = position
        
        addChild(character.node)
        
        return character
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
