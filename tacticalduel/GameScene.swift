//
//  GameScene.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 07/05/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import SpriteKit
import GameplayKit
import Hexamap

class GameScene: SKScene {
    let mapView = HxMapView(radius: 4, edge: 20)

    override func sceneDidLoad() {
        for cell in mapView.map.cells.filter({ abs($0.q + $0.r) <= mapView.map.radius }) {
            let (_, points) = mapView.point(for: cell)
            var shapePoints = points.map { CGPoint(x: self.frame.width / 2 + $0.x, y: self.frame.height / 2 - $0.y) }
            let shape = SKShapeNode(points: &shapePoints, count: shapePoints.count)
            addChild(shape)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
