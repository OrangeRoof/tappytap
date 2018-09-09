import Foundation

struct Beat : Equatable {
	let time : Double
	let key : Character
	//func within(k: Character, t: Double, d: Double) ??
	func within(t: Double, d: Double) -> Bool{
		return(((t-d)..<(t+d)).contains(time))
	}
}

struct Level{
	private let l : [Beat]
	init(filename f: String) throws{
		let p = Bundle.main.path(forResource: f, ofType: nil)
		// TODO: depending on file size this could be very costly!
		guard let a = try? String(contentsOfFile: p!, encoding: .utf8).split(separator: "\n") else{
			throw NSError(domain: "Error opening Level file", code: 23)
		}
		var k : [Beat] = []
		for t in a {
			let x = t.split(separator: " ")
			k.append(Beat(time: Double(x[0])!, key: Character(String(x[1]))))
		}
		l = k
	}
	func getBeat(time t: Double) -> Beat?{
		return l.first(where: {$0.time == t})
	}
	func getBeatRange(range r: ClosedRange<Double>) -> [Beat]{
		return l.filter{r.contains($0.time)}
	}
}

class Game{
	enum diff{case easy, medium, hard}
	
	let d : diff
	let l : Level
	let beatFadeTimeMax : Double
	var score = 0
	var gameTime : Double
	var curBeats : [(b: Beat, p: Double)] = []
	
	init(filename f: String, difficulty d: diff) throws{
		self.d = d
		switch (d){
		case .easy:
			beatFadeTimeMax = 1.0
		case .medium:
			beatFadeTimeMax = 0.75
		case .hard:
			beatFadeTimeMax = 0.5
		}
		gameTime = 0.0
		l = try! Level(filename: f)
		if let b = l.getBeat(time: 0.0){
			curBeats.append((b, 0.0))
		}
	}
	
	func update(delta: Double){
		// ISSUE: beats are not being added in at the correct time... i.e. if you use a 0.15 second delay the second beat doesn't get added in until 0.15 (when it should be 0.1)
		// Not sure how big of an issue this is: when would it be important? where would your beat time ever be bigger than your game time?
		for i in (0 ..< curBeats.count).reversed() {
			if (curBeats[i].p <= beatFadeTimeMax) {
				curBeats[i].p += delta
			} else {
				curBeats.remove(at: i)
			}
		}
		for b in l.getBeatRange(range: (gameTime)...(gameTime+delta)){
			if (!curBeats.contains{$0.b == b}){
				curBeats.append((b, 0.0))
			}
		}
		gameTime += delta
	}
}
