//
//  Character.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 14/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import SpriteKit

class Character {
    let node: SKSpriteNode
    let name: String
    
    private(set) var q: Int
    private(set) var r: Int
    
    init(q: Int, r: Int, name: String, edge: CGFloat) {
        node = SKSpriteNode(imageNamed: name)
        let width = node.frame.width
        let height = node.frame.height
        let scale = edge / width
        node.scale(to: CGSize(width: edge, height: height * scale))
        
        self.name = name
        
        self.q = q
        self.r = r
    }
    
    func setPosition(q: Int, r: Int) {
        self.q = q
        self.r = r
    }
}
