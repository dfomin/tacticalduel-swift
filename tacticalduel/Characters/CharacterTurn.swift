//
//  CharacterTurn.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 22/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class CharacterTurn {
    var actions: [TurnAction?]
    
    init(numberOfActions: Int) {
        actions = [TurnAction?](repeating: nil, count: numberOfActions)
    }
    
    subscript(index: Int) -> TurnAction? {
        get {
            return actions[index]
        }
        set {
            actions[index] = newValue
        }
    }
    
    func append(action: TurnAction) {
        guard let index = actions.firstIndex(where: { $0 == nil }) else {
            return
        }
        
        actions[index] = action
    }
}
