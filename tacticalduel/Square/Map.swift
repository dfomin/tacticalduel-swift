//
//  Map.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 01/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

protocol Map {
    func add(object: MapObject, at position: Position) -> Int
    func move(object objectId: Int, to newPosition: Position)
    func remove(object objectId: Int) -> MapObject
}
