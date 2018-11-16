//
//  Temporary.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 16/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol Temporary {
    var turnsLeft: Int { get }
    func turnIsOver()
}
