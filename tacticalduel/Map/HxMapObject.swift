//
//  HxMapObject.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 24/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class HxMapObject {
    let name: String
    var coordinates: HxCoordinates
    
    init(name: String, coordinates: HxCoordinates) {
        self.name = name
        self.coordinates = coordinates
    }
}

extension HxMapObject: Equatable {
    static func == (lhs: HxMapObject, rhs: HxMapObject) -> Bool {
        return lhs.name == rhs.name
    }
}
