//
//  HxCellView.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 14/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import SpriteKit

class HxCellView {
    let node: SKShapeNode
    
    init(center: CGPoint, edge: CGFloat) {
        let x = center.x
        let y = center.y
        
        var path = [
            CGPoint(x: x - edge, y: y),
            CGPoint(x: x - edge / 2, y: y - edge * sqrt(3) / 2),
            CGPoint(x: x + edge / 2, y: y - edge * sqrt(3) / 2),
            CGPoint(x: x + edge, y: y),
            CGPoint(x: x + edge / 2, y: y + edge * sqrt(3) / 2),
            CGPoint(x: x - edge / 2, y: y + edge * sqrt(3) / 2),
            CGPoint(x: x - edge, y: y)
        ]
        
        node = SKShapeNode(points: &path, count: path.count)
    }
    
    func set(color: UIColor) {
        node.fillColor = color
    }
}
