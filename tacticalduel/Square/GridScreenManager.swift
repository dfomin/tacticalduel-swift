//
//  GridScreenManager.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 11/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import SpriteKit

class GridScreenManager {
    
    private let field: CGRect
    
    let cellSize: CGSize
    
    init(field: CGRect, gridSize: (Int, Int)) {
        self.field = field
        
        let cellWidth = field.width / CGFloat(gridSize.0)
        let cellHeight = field.height / CGFloat(gridSize.1)
        self.cellSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    func gridPosition(for screenPosition: CGPoint) -> (Int, Int)? {
        guard field.contains(screenPosition) else { return nil }
        
        let x = Int((screenPosition.x - self.field.minX) / self.cellSize.width)
        let y = Int((screenPosition.y - self.field.minY) / self.cellSize.height)
        return (x, y)
    }
    
    func screenPosition(for gridPosition: (Int, Int)) -> CGPoint {
        let cellWidth = self.cellSize.width
        let cellHeight = self.cellSize.height
        let x = CGFloat(gridPosition.0) * cellWidth + cellWidth / CGFloat(2) + self.field.minX
        let y = CGFloat(gridPosition.1) * cellHeight + cellHeight / CGFloat(2) + self.field.minY
        return CGPoint(x: x, y: y)
    }
}
