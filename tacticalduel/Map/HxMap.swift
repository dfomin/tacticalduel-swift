//
//  HxMap.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 07/05/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol HxMapDelegate: class {
    func didAdd(object: HxMapObject)
    func didMove(object: HxMapObject)
    func didRemove(object: HxMapObject)
}

class HxMap {
    private let grid: HxGrid

    var radius: Int {
        return grid.radius
    }
    
    weak var delegate: HxMapDelegate?

    init(radius: Int) {
        grid = HxGrid(radius: radius)
    }
    
    func add(object: HxMapObject, at coordinates: HxCoordinates) {
        guard let cell = self.cell(at: coordinates) else {
            assert(false)
            return
        }
        
        cell.mapObjects = [object]
        
        delegate?.didAdd(object: object)
    }
    
    func move(object: HxMapObject, to: HxCoordinates) {
        guard let oldCell = self.cell(at: object.coordinates), let newCell = self.cell(at: to) else {
            assert(false)
            return
        }
        
        oldCell.mapObjects = []
        newCell.mapObjects = [object]
        
        object.coordinates = to
        
        delegate?.didMove(object: object)
    }
    
    func remove(object: HxMapObject, at coordinates: HxCoordinates) {
        guard let cell = self.cell(at: coordinates) else {
            assert(false)
            return
        }
        
        cell.mapObjects = []
        
        delegate?.didRemove(object: object)
    }
    
    func cell(at coordinates: HxCoordinates) -> HxCell? {
        if isInside(coordinates: coordinates) {
            return grid.cell(at: coordinates)
        } else {
            return nil
        }
    }
    
    func isInside(coordinates: HxCoordinates) -> Bool {
        return abs(coordinates.q) <= radius && abs(coordinates.r) <= radius && abs(coordinates.q + coordinates.r) <= radius
    }
    
    func neighbors(of coordinates: HxCoordinates) -> [HxCoordinates] {
        let q = coordinates.q
        let r = coordinates.r
        
        let coordinates = [
            HxCoordinates(q, r - 1),
            HxCoordinates(q, r + 1),
            HxCoordinates(q - 1, r),
            HxCoordinates(q + 1, r),
            HxCoordinates(q - 1, r + 1),
            HxCoordinates(q + 1, r - 1)]
        
        return coordinates.filter { isInside(coordinates: $0) }
    }
    
    func straightPath(from coordinates: HxCoordinates, to direction: HxDirection) -> [HxCoordinates] {
        var nextCoordinates = coordinates + direction.relativeCoordinates
        var path = [HxCoordinates]()
        while isInside(coordinates: nextCoordinates) {
            path.append(nextCoordinates)
            nextCoordinates = nextCoordinates + direction.relativeCoordinates
        }
        
        return path
    }
    
    func section(from start: HxCoordinates, to target: HxCoordinates, length: Int?) -> [HxCoordinates] {
        // Don't allow this
        var diff = target - start
        if diff.q == 0 || diff.r == 0 || (diff.q + diff.r == 0) {
            diff = HxCoordinates(1, 1)
        }
        
        var result = [HxCoordinates]()
        for r in -radius ... radius {
            for q in -radius ... radius {
                let coordinates = HxCoordinates(q, r)
                let cellDiff = coordinates - start
                if isInside(coordinates: coordinates) {
                    if (diff.q * cellDiff.q < 0) || (diff.r * cellDiff.r < 0) || (diff.q + diff.r) * (cellDiff.q + cellDiff.r) < 0 {
                        continue
                    }
                    
                    if let length = length {
                        if distance(start, coordinates) > length {
                            continue
                        }
                    }
                    
                    result.append(coordinates)
                }
            }
        }
        
        return result
    }
    
    /*func range(from cell: HxCell, radius: Int) -> [HxCell] {
        let q = cell.q
        let r = cell.r
        
        return [HxCell]()
    }*/
}
