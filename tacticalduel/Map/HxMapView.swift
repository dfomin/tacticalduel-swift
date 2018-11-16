//
//  HxMapView.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 13/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import SpriteKit

class HxMapView {
    private let edge: CGFloat
    private var actions = [SKNode: [SKAction]]()
    private let cellViews: [HxCoordinates: HxCellView]
    private var sprites = [String: SKNode]()
    private var objects = [String: HxMapObject]()
    
    let node: SKNode
    let map: HxMap
    
    init(radius: Int, edge: CGFloat, center: CGPoint) {
        self.edge = edge
        map = HxMap(radius: radius)
        
        node = SKNode()
        node.position = center
        
        var views = [HxCoordinates: HxCellView]()
        
        for r in -radius ... radius {
            for q in -radius ... radius {
                let coordinates = HxCoordinates(q, r)
                if map.isInside(coordinates: coordinates) {
                    let sqrt_3 = CGFloat(sqrt(3))
                    let x = edge * CGFloat(coordinates.q) * 3 / 2
                    let y = -edge * (CGFloat(coordinates.q) * sqrt_3 / 2 + CGFloat(coordinates.r) * sqrt_3)
                    let cellView = HxCellView(center: CGPoint(x: x, y: y), edge: edge)
                    views[coordinates] = cellView
                    node.addChild(cellView.node)
                }
            }
        }
        
        self.cellViews = views
        
        map.delegate = self
    }
    
    func add(objectView: SKNode, for name: String) {
        let object = objects[name]!
        sprites[name] = objectView
        
        let position = point(at: object.coordinates)
        objectView.position = position
        node.addChild(objectView)
    }
    
    func wait(objectView: HxMapObjectView) {
        actions[objectView.node, default: []].append(SKAction.wait(forDuration: 0.5))
    }
    
    func runActions() {
        for node in actions.keys {
            node.run(SKAction.sequence(actions[node]!))
            actions[node] = []
        }
    }
    
    func set(color: UIColor, for coordinates: HxCoordinates) {
        guard let cellView = cellViews[coordinates] else {
            assert(false)
            return
        }
        
        cellView.set(color: color)
    }
    
    func point(at coordinates: HxCoordinates) -> CGPoint {
        let sqrt_3 = CGFloat(sqrt(3))
        let x = edge * CGFloat(coordinates.q) * 3 / 2
        let y = edge * (CGFloat(coordinates.q) * sqrt_3 / 2 + CGFloat(coordinates.r) * sqrt_3)
        let center = CGPoint(x: x, y: -y)
        return center
    }
    
    func coordinates(at point: CGPoint) -> HxCoordinates {
        let q = (point.x * 2 / 3) / edge
        let constant = CGFloat(sqrt(3) / 3)
        let r = (-point.x / 3 + point.y * constant) / edge
        return nearestHex(q: q, r: r)
    }
    
    private func nearestHex(q: CGFloat, r: CGFloat) -> HxCoordinates {
        let x = q
        let z = r
        let y = -q - r
        
        var rx = round(x)
        var ry = round(y)
        var rz = round(z)
        
        let xDiff = abs(rx - x)
        let yDiff = abs(ry - y)
        let zDiff = abs(rz - z)
        
        if xDiff > yDiff && xDiff > zDiff {
            rx = -ry - rz
        } else if yDiff > zDiff {
            ry = -rx - rz
        } else {
            rz = -rx - ry
        }
        
        return HxCoordinates(Int(rx), Int(rz))
    }
}

extension HxMapView: HxMapDelegate {
    func didAdd(object: HxMapObject) {
        objects[object.name] = object
    }
    
    func didMove(object: HxMapObject) {
        let position = point(at: object.coordinates)
        actions[sprites[object.name]!, default: []].append(SKAction.move(to: position, duration: 0.5))
    }
    
    func didRemove(object: HxMapObject) {
        sprites[object.name]?.removeFromParent()
    }
}
