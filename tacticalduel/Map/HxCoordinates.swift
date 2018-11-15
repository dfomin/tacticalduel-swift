//
//  HxCoordinates.swift
//  Hexamap
//
//  Created by Dmitry Fomin on 21/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

struct HxCoordinates: Equatable, Hashable {
    let q: Int
    let r: Int
    
    init(q: Int, r: Int) {
        self.q = q
        self.r = r
    }
    
    init(_ q: Int, _ r: Int) {
        self.init(q: q, r: r)
    }
}

func +(lhs: HxCoordinates, rhs: HxCoordinates) -> HxCoordinates {
    return HxCoordinates(q: lhs.q + rhs.q, r: lhs.r + rhs.r)
}

func -(lhs: HxCoordinates, rhs: HxCoordinates) -> HxCoordinates {
    return HxCoordinates(q: lhs.q - rhs.q, r: lhs.r - rhs.r)
}

func distance(_ point1: HxCoordinates, _ point2: HxCoordinates) -> Int {
    let q1 = point1.q
    let r1 = point1.r
    let q2 = point2.q
    let r2 = point2.r
    return (abs(q1 - q2) + abs(r1 - r2) + abs(q1 + r1 - q2 - r2)) / 2
}
