//
//  HxGrid.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 09/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class HxGrid {
    let cells: [HxCell]
    let radius: Int
    
    init(radius: Int) {
        self.radius = radius
        
        var cells = [HxCell]()
        for _ in 0 ..< (2 * radius + 1) * (2 * radius + 1) {
            cells.append(HxCell())
        }
        
        self.cells = cells
    }
    
    func cell(at coordinates: HxCoordinates) -> HxCell {
        let q = coordinates.q
        let r = coordinates.r
        let column = q + (r - abs(r % 2)) / 2 + radius
        let row = r + radius
        return cells[row * (radius * 2 + 1) + column]
    }
}
