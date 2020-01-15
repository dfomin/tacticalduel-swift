//
//  GridPositionComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 11/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit

class GridPositionComponent: GKComponent {
    
    var position: (Int, Int)
    
    init(position: (Int, Int)) {
        self.position = position
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
