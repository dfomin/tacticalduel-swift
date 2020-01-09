//
//  HealthViewComponent.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 09/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

import GameplayKit
import SpriteKit

class HealthViewComponent: GKComponent {
    
    private(set) var label: SKLabelNode
    
    var health: Int {
        didSet {
            label.text = String(health)
        }
    }
    
    init(health: Int) {
        self.health = health
        self.label = SKLabelNode(text: String(health))
        self.label.fontColor = .white
        self.label.fontName = self.label.fontName! + "-Bold"
        self.label.verticalAlignmentMode = .center
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
