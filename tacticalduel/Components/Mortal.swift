//
//  Mortal.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 24/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol Mortal {
    var health: Int { get }
    var maxHealth: Int { get }
    
    func apply(damage: Int)
}
