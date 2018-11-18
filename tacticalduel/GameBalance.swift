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
    var freezeTurnsNumber = 1
    var invisibilityTurnsNumber = 3
    
    var fireSectionLength = 3
    
    var commonShootSlots = 1
    var skipSlots = 1
    var moveSlots = 1
    var splashShootSlots = 2
    var allDirectionsShootSlots = 2
    var throwStoneSlots = 2
    var lightningSlots = 2
    var fireSectionSlots = 2
    var oneDirectionShootSlots = 2
    var blowSlots = 2
    var healSlots = 2
    var fireTrapSlots = 2
    var poisonSlots = 2
    var freezeSlots = 2
    var invisibilitySlots = 2
    
    var turnsNumber = 3
    
    private init() {}
}
