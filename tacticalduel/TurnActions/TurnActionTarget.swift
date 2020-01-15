//
//  ActionTarget.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 01/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

protocol ActionTarget: Action {
    var target: HxCoordinates { get set }
}
