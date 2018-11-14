//
//  Movable.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 15/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol Movable {
    var weight: Int { get }
    func apply(force: Int) -> Int
}
