import SpriteKit

class BeatTestScene: SKScene{
	var beatFactory = SKShapeNode(rectOf: CGSize(width: 25, height: 25))
	var tapRegion = SKShapeNode(circleOfRadius: 350.0)
	let path = CGMutablePath()
	var t : CGFloat = 0.0
	
	
	override func sceneDidLoad() {
		self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		tapRegion.strokeColor = .black
		beatFactory.strokeColor = .black
		beatFactory.fillColor = .red
		beatFactory.position = CGPoint.zero
		
		path.move(to: .zero); path.addLine(to: CGPoint(x: 350.0, y: 0.0))
		let line = SKShapeNode.init(path: path)
		line.strokeColor = .black; line.zPosition = -1
		
		self.addChild(beatFactory)
		//self.addChild(tapRegion)
		for theta in stride(from: 0.0, through: .pi*2.0, by: .pi*0.3333) {
			let l = line.copy() as! SKShapeNode
			l.zRotation = CGFloat(theta)
			self.addChild(l)
		}
	}
	
	func setSail(node: SKShapeNode, theta: CGFloat, path: CGPath){
		let n : SKShapeNode = node.copy() as! SKShapeNode
		var trans = CGAffineTransform.init(rotationAngle: theta)
		let p = path.copy(using: &trans)!
		n.run(.sequence([.follow(p, speed: 120.0),
						 .removeFromParent()
			]))
		self.addChild(n)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches{
			let p = t.location(in: self)
			setSail(node: beatFactory, theta: atan2(p.y, p.x), path: path)
		}
	}
	
	override func update(_ currentTime: TimeInterval) {
		setSail(node: beatFactory, theta: t, path: path)
		t += .pi*0.1616
	}
}
