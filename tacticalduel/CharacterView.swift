//
//  CharacterView.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 23/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap
import SpriteKit

class CharacterView {
    let character: Character
    let node: SKSpriteNode
    let name: String
    
    init(coordinates: HxCoordinates, name: String, edge: CGFloat, map: HxMap) {
        self.character = Character(coordinates: coordinates, map: map)
        self.name = name
        
        node = SKSpriteNode(imageNamed: name)
        let width = node.frame.width
        let height = node.frame.height
        let scale = edge / width
        node.scale(to: CGSize(width: edge, height: height * scale))
    }
}
