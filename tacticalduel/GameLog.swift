//
//  GameLog.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 20/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Foundation

class GameLog {
    let name: String
    var log = ""
    var lastTurn = ""
    
    init() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        name = formatter.string(from: date)
    }
    
    func add(team: String, heroes: [String]) {
        lastTurn += team + ": " + heroes.joined(separator: ",") + "\n"
    }
    
    func add(hero: String, action: TurnAction) {
        var target = ""
        if let targetAction = action as? TurnActionTarget {
            target = "\(targetAction.target.q),\(targetAction.target.r)"
        }
        
        lastTurn += hero + " " + action.iconName + " " + target + "\n"
    }
    
    func add(event: String) {
        lastTurn += event + "\n"
    }
    
    func commit() {
        log += lastTurn
        lastTurn = ""
    }
}
