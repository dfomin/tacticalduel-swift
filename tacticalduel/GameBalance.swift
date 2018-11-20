//
//  GameBalance.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 01/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Foundation

class GameBalance {
    static let shared = GameBalance()
    
    let heros = [
        "night",
        "fire",
        "water",
        "stone",
        "ent",
        "weather"
    ]
    
    let keys = [
        ("health", 100),
        ("commonShootDamage", 5),
        ("throwStoneDamage", 30),
        ("allDirectionsDamage", 10),
        ("lianaSplashDamage", 15),
        ("lightningDamage", 20),
        ("fireSectionDamage", 10),
        ("oneDirectionDamage", 20),
        ("heal", 10),
        ("fireTrapDamage", 5),
        ("fireTrapCount", 3),
        ("poisonTurnsCount", 3),
        ("poisonDamage", 10),
        ("freezeTurnsNumber", 1),
        ("invisibilityTurnsNumber", 3),
        ("fireSectionLength", 3),
        ("commonShootSlots", 1),
        ("skipSlots", 1),
        ("moveSlots", 1),
        ("splashShootSlots", 2),
        ("allDirectionsShootSlots", 2),
        ("throwStoneSlots", 2),
        ("lightningSlots", 2),
        ("fireSectionSlots", 2),
        ("oneDirectionShootSlots", 2),
        ("blowSlots", 2),
        ("healSlots", 2),
        ("fireTrapSlots", 2),
        ("poisonSlots", 2),
        ("freezeSlots", 2),
        ("invisibilitySlots", 2),
        ("turnsNumber", 3)
    ]
    
    subscript(key: String) -> Int {
        get {
            return UserDefaults.standard.value(forKey: key) as? Int ?? keys[keys.firstIndex(where: { $0.0 == key })!].1
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    var health: Int {
        get {
            return UserDefaults.standard.value(forKey: "health") as? Int ?? 100
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "health")
        }
    }
    
    var commonShootDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "commonShootDamage") as? Int ?? 5
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "commonShootDamage")
        }
    }
    
    var throwStoneDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "throwStoneDamage") as? Int ?? 30
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "throwStoneDamage")
        }
    }
    var allDirectionsDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "allDirectionsDamage") as? Int ?? 15
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "allDirectionsDamage")
        }
    }
    var lianaSplashDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "lianaSplashDamage") as? Int ?? 15
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lianaSplashDamage")
        }
    }
    var lightningDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "lightningDamage") as? Int ?? 20
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lightningDamage")
        }
    }
    var fireSectionDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "fireSectionDamage") as? Int ?? 10
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fireSectionDamage")
        }
    }
    var oneDirectionDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "oneDirectionDamage") as? Int ?? 20
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "oneDirectionDamage")
        }
    }
    var heal: Int {
        get {
            return UserDefaults.standard.value(forKey: "heal") as? Int ?? 10
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "heal")
        }
    }
    var fireTrapDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "fireTrapDamage") as? Int ?? 5
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fireTrapDamage")
        }
    }
    var fireTrapCount: Int {
        get {
            return UserDefaults.standard.value(forKey: "fireTrapCount") as? Int ?? 3
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fireTrapCount")
        }
    }
    var poisonTurnsCount: Int {
        get {
            return UserDefaults.standard.value(forKey: "poisonTurnsCount") as? Int ?? 3
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "poisonTurnsCount")
        }
    }
    var poisonDamage: Int {
        get {
            return UserDefaults.standard.value(forKey: "poisonDamage") as? Int ?? 10
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "poisonDamage")
        }
    }
    var freezeTurnsNumber: Int {
        get {
            return UserDefaults.standard.value(forKey: "freezeTurnsNumber") as? Int ?? 1
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "freezeTurnsNumber")
        }
    }
    var invisibilityTurnsNumber: Int {
        get {
            return UserDefaults.standard.value(forKey: "invisibilityTurnsNumber") as? Int ?? 3
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "invisibilityTurnsNumber")
        }
    }
    
    var fireSectionLength: Int {
        get {
            return UserDefaults.standard.value(forKey: "fireSectionLength") as? Int ?? 3
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fireSectionLength")
        }
    }
    
    var commonShootSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "commonShootSlots") as? Int ?? 1
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "commonShootSlots")
        }
    }
    var skipSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "skipSlots") as? Int ?? 1
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "skipSlots")
        }
    }
    var moveSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "moveSlots") as? Int ?? 1
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "moveSlots")
        }
    }
    var splashShootSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "splashShootSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "splashShootSlots")
        }
    }
    var allDirectionsShootSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "allDirectionsShootSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "allDirectionsShootSlots")
        }
    }
    var throwStoneSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "throwStoneSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "throwStoneSlots")
        }
    }
    var lightningSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "lightningSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "lightningSlots")
        }
    }
    var fireSectionSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "fireSectionSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fireSectionSlots")
        }
    }
    var oneDirectionShootSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "oneDirectionShootSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "oneDirectionShootSlots")
        }
    }
    var blowSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "blowSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "blowSlots")
        }
    }
    var healSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "healSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "healSlots")
        }
    }
    var fireTrapSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "fireTrapSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fireTrapSlots")
        }
    }
    var poisonSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "poisonSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "poisonSlots")
        }
    }
    var freezeSlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "freezeSlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "freezeSlots")
        }
    }
    var invisibilitySlots: Int {
        get {
            return UserDefaults.standard.value(forKey: "invisibilitySlots") as? Int ?? 2
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "invisibilitySlots")
        }
    }
    
    var turnsNumber: Int {
        get {
            return UserDefaults.standard.value(forKey: "turnsNumber") as? Int ?? 3
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "turnsNumber")
        }
    }
    
    private init() {}
}
