//
//  TurnAction.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 21/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import Hexamap

protocol TurnAction {
    var iconName: String { get }
    
    func doAction()
}
