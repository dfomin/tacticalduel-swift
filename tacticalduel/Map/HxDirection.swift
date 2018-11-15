//
//  HxDirection.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 21/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

enum HxDirection: CaseIterable {
    case oclock2
    case oclock4
    case oclock6
    case oclock8
    case oclock10
    case oclock12
    
    init?(coordinates: HxCoordinates) {
        switch coordinates {
        case HxCoordinates(1, -1):
            self = .oclock2
        case HxCoordinates(1, 0):
            self = .oclock4
        case HxCoordinates(0, 1):
            self = .oclock6
        case HxCoordinates(-1, 1):
            self = .oclock8
        case HxCoordinates(-1, 0):
            self = .oclock10
        case HxCoordinates(0, -1):
            self = .oclock12
        default:
            return nil
        }
    }
    
    var relativeCoordinates: HxCoordinates {
        switch self {
        case .oclock2:
            return HxCoordinates(q: 1, r: -1)
        case .oclock4:
            return HxCoordinates(q: 1, r: 0)
        case .oclock6:
            return HxCoordinates(q: 0, r: 1)
        case .oclock8:
            return HxCoordinates(q: -1, r: 1)
        case .oclock10:
            return HxCoordinates(q: -1, r: 0)
        case .oclock12:
            return HxCoordinates(q: 0, r: -1)
        }
    }
}
