//
//  TurnActionDamage.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 21/10/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol TurnActionDamage: TurnActionTarget {
    var targetArea: [HxCoordinates] { get }
    
    func damage(at coordinates: HxCoordinates) -> Int
}
