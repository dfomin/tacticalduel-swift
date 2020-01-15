//
//  CharacterTurn.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 22/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

class CharacterTurn {
    var actions: [Action?]
    
    init(numberOfActions: Int) {
        actions = [Action?](repeating: nil, count: numberOfActions)
    }
    
    subscript(index: Int) -> Action? {
        get {
            return actions[index]
        }
        set {
            actions[index] = newValue
        }
    }
    
    func hasSpaceFor(slots: Int) -> Bool {
        var count = 0
        var maxCount = 0
        for i in 0 ..< actions.count {
            if actions[i] == nil {
                count += 1
            } else {
                if maxCount < count {
                    maxCount = count
                }
                count = 0
            }
        }
        
        if maxCount < count {
            maxCount = count
        }
        
        return maxCount >= slots
    }
    
    func append(action: Action) {
        for i in 0 ..< actions.count {
            if actions[i] == nil {
                var isOk = true
                for j in i ..< i + action.turnSlots {
                    if actions[j] != nil {
                        isOk = false
                        break
                    }
                }
                
                if isOk {
                    actions[i] = action
                    if action.turnSlots > 1 {
                        for j in i + 1 ..< i + action.turnSlots {
                            actions[j] = ActionSlot()
                        }
                    }
                    
                    return
                }
            }
        }
    }
    
    func remove(at index: Int) {
        if actions[index] is ActionSlot {
            var i = index
            while i >= 0 {
                if actions[i] is ActionSlot {
                    actions[i] = nil
                } else {
                    actions[i] = nil
                    break
                }
                
                i -= 1
            }
            
            i = index
            while i < actions.count {
                if actions[i] is ActionSlot {
                    actions[i] = nil
                } else {
                    break
                }
                
                i += 1
            }
        } else {
            actions[index] = nil
            var i = index + 1
            while i < actions.count && actions[i] is ActionSlot {
                actions[i] = nil
                i += 1
            }
        }
    }
}
