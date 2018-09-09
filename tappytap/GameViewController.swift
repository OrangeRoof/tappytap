//
//  GameViewController.swift
//  tappytap
//
//  Created by Alex on 2018-08-22.
//  Copyright © 2018 alch. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
			let scene = BeatTestScene(size: view.frame.size)
			// Set the scale mode to scale to fit the window
			scene.scaleMode = .aspectFill
			
			// Present the scene
			view.presentScene(scene)
			view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
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
