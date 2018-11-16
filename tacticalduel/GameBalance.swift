//
//  GameBalance.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 01/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class GameBalance {
    static let shared = GameBalance()
    
    var commonShootDamage = 5
    var throwStoneDamage = 30
    var allDirectionsDamage = 15
    var lianaSplashDamage = 15
    var lightningDamage = 20
    var fireSectionDamage = 10
    var oneDirectionDamage = 20
    var heal = 10
    var fireTrapDamage = 5
    var fireTrapCount = 3
    var poisonTurnsCount = 3
    var poisonDamage = 10
    
    var fireSectionLength = 3
    
    private init() {}
}
