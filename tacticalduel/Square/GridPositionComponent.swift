//
//  GridPositionComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 08/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class GridPositionComponent: GKComponent {
    
    private(set) var field: CGRect!
    private(set) var gridSize: (Int, Int)!
    
    var position: (Int, Int)!
    
    var spritePosition: CGPoint {
        let cellWidth = self.spriteSize.width
        let cellHeight = self.spriteSize.height
        let x = CGFloat(self.position.0) * cellWidth + cellWidth / CGFloat(2) + self.field.minX
        let y = CGFloat(self.position.1) * cellHeight + cellHeight / CGFloat(2) + self.field.minY
        return CGPoint(x: x, y: y)
    }
    
    var spriteSize: CGSize {
        let cellWidth = self.field.width / CGFloat(self.gridSize.0)
        let cellHeight = self.field.height / CGFloat(self.gridSize.1)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    init(field: CGRect, gridSize: (Int, Int), initialPosition: (Int, Int)) {
        self.field = field
        self.gridSize = gridSize
        self.position = initialPosition
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
