//
//  Freezable.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 17/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol Freezable: Temporary {
    func isFreezed() -> Bool
    func freeze(turnsNumber: Int)
}
