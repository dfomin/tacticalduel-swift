//
//  CharacterView.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 23/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap
import SpriteKit

class CharacterView: HxMapObjectView {
    let character: Character
    let node: SKNode
    let name: String
    
    var mapObject: HxMapObject {
        return character
    }
    
    init(coordinates: HxCoordinates, name: String, edge: CGFloat) {
        self.character = Character(coordinates: coordinates, health: 100)
        self.name = name
        
        let sprite = SKSpriteNode(imageNamed: name)
        let width = sprite.frame.width
        let height = sprite.frame.height
        let scale = edge / width
        sprite.scale(to: CGSize(width: edge, height: height * scale))
        node = sprite
    }
}
