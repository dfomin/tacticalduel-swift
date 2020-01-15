//
//  MoveAction.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 11/01/2020.
//  Copyright © 2020 Dmitry Fomin. All rights reserved.
//

class MoveAction: Action {
    
    let shift: (Int, Int)
    
    let iconName = ""
    let turnSlots = 1
    
    init(shift: (Int, Int)) {
        self.shift = shift
    }
}
