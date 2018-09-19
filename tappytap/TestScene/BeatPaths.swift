//
//  beatPaths.swift
//  tappytap
//
//  Created by Alex on 2018-09-10.
//  Copyright © 2018 alch. All rights reserved.
//

import Foundation
import SpriteKit

class BeatPaths {
	private let paths : [SKAction]
	let radius : CGFloat
	let count : Int
	
	init(radius r: CGFloat, speed v: CGFloat, pathCount c: Int){
		count = c; radius = r
		
		let path = CGMutablePath()
		path.move(to: .zero); path.addLine(to: CGPoint(x: r, y: 0.0))
		var actions : [SKAction] = []
		for theta in stride(from: 0.0, through: .pi*2.0, by: (.pi*2.0)/Double(c)) {
			var trans = CGAffineTransform.init(rotationAngle: CGFloat(theta))
			let p = path.copy(using: &trans)!
			actions.append(.sequence([SKAction.follow(p, speed: v),
									SKAction.removeFromParent()
				]))
		}
		paths = actions
	}
	
	func getAction(k: Int) -> SKAction {
		return paths[k % count]
	}
	
	func getAction(theta: CGFloat) -> SKAction {
		let n = Int(theta.truncatingRemainder(dividingBy: .pi*2.0) / (.pi * 2.0 / CGFloat(count)))
		return paths[n]
	}
}
