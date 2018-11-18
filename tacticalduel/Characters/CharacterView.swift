//
//  CharacterView.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 23/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import SpriteKit

class CharacterView: HxMapObjectView {
    let character: Character
    let node: SKNode
    let hp: SKLabelNode
    
    var name: String {
        return character.name
    }
    
    var mapObject: HxMapObject {
        return character
    }
    
    init(coordinates: HxCoordinates, name: String, team: String, edge: CGFloat) {
        character = Character(name: name, team: team, coordinates: coordinates, health: 100)
        
        let sprite = SKSpriteNode(imageNamed: name)
        let width = sprite.frame.width
        let height = sprite.frame.height
        let scale = edge / width
        sprite.scale(to: CGSize(width: edge, height: height * scale))
        node = sprite
        
        hp = SKLabelNode(text: String(character.health))
        hp.fontSize = 10
        hp.fontColor = .red
        hp.fontName = "AvenirNext-Bold"
        hp.position = CGPoint(x: 0, y: -sprite.frame.height/2)
        hp.zPosition = 1
        node.addChild(hp)
        
        character.delegate = self
    }
}

extension CharacterView: CharacterDelegate {
    func healthDidChange() {
        hp.text = String(character.health)
    }
}
