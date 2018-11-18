//
//  GameViewController.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 07/05/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var heroes1 = [String]()
    var heroes2 = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        let positions1 = [(0, -3), (-3, 0), (3, -3), (0, -2), (-2, 0), (2, -2)]
        let positions2 = [(0, 3), (3, 0), (-3, 3), (0, 2), (2, 0), (-2, 2)]
        scene.createTeam(name: "team 1", heroes: heroes1, positions: positions1)
        scene.createTeam(name: "team 2", heroes: heroes2, positions: positions2)
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
