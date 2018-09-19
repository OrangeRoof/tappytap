import SpriteKit

class BeatTestScene: SKScene{
	let lf = BeatPaths(radius: 350.0, speed: 120.0, pathCount: 6)
	
	//DEBUG Variables
	var beatFactory = SKShapeNode(rectOf: CGSize(width: 25, height: 25))
	var tapRegion = SKShapeNode(circleOfRadius: 350.0)
	var t : Int = 0
	
	override func sceneDidLoad() {
		// DEBUG only! to be replaced with textures
		self.backgroundColor = .white
		self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		tapRegion.strokeColor = .black
		beatFactory.strokeColor = .black
		beatFactory.fillColor = .red
		beatFactory.position = CGPoint.zero
		self.addChild(beatFactory)
		self.addChild(tapRegion)
		var linedef = [CGPoint.zero, CGPoint(x: 0, y: 350)]
		let line = SKShapeNode(points: &linedef, count: 2)
		line.strokeColor = .black; line.zPosition = -1
		for theta in stride(from: 0.0, through: .pi*2.0, by: .pi*0.3333) {
			let l = line.copy() as! SKShapeNode
			l.zRotation = CGFloat(theta)
			self.addChild(l)
		}
		
	}
	
	func setSail(node: SKShapeNode, k: Int){
		let n : SKShapeNode = node.copy() as! SKShapeNode
		n.run(lf.getAction(k: k))
		self.addChild(n)
	}
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for t in touches{
			let p = t.location(in: self)
			for n in self.nodes(at: p){
				if (n as! SKShapeNode).fillColor == .red {
					print(n)
					(n as! SKShapeNode).fillColor = .green
				}
			}
		}
	}
	
	override func update(_ currentTime: TimeInterval) {
		if(Int(currentTime*10) % 10 == 0){
			t += 1
			setSail(node: beatFactory, k: t)
		}
	}
}
