import UIKit

///Protocols allow you to group similar methods, functions and properties. Swift lets you specify these interface guarantees on class, struct and enum types. Only class types can use base classes and inheritance.

///An advantage of protocols in Swift is that objects can conform to multiple protocols.

///When writing an app this way, your code becomes more modular. Think of protocols as building blocks of functionality. When you add new functionality by conforming an object to a protocol, you don’t build a whole new object. That’s time-consuming. Instead, you add different building blocks until your object is ready.


protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

extension Bird {
    ///Flyable birds can fly!. It sets the default behaviour for canFly to return true whenever the type conforms to the Flyable protocol. In other words, any Flyable bird no longer needs to explicitly declare it canFly. It will simply fly, as most birds do.
    var canFly: Bool { self is Flyable }
}

///You can also conform your own protocols to other protocols from the Swift standard library and define default behaviours

///Conforming to CustomStringConvertible means your type needs to have a description property so it be converted to a String automatically when needed

extension CustomStringConvertible where Self: Bird {
    var description: String {
        canFly ? "I can fly" : "Guess I'll just sit here :["
    }
}

protocol Flyable {
    var airspeedVelocity: Double { get }
}

//MARK: - FlappyBird
struct FlappyBird: Bird, Flyable {
    var name: String

    let flappyAmplitude: Double
    let flappyFrequency: Double

    var airspeedVelocity: Double {
        3 * flappyFrequency * flappyAmplitude
    }
}

//MARK: - Penguin
struct Penguin: Bird {
    var name: String
}

//MARK: - SwiftBird
struct SwiftBird: Bird, Flyable {
    var name: String {"Swift \(version)"}

    let version: Double
    private var speedFactor = 1000.0

    init(version: Double) {
        self.version = version
    }

    var airspeedVelocity: Double {
        version * speedFactor
    }
}

///Enum types in Swift are much more powerful than enums from C and C++. They adopt many features that only class or struct types traditionally support, meaning they can conform to protocols.

//MARK: - UnladenSwallow
enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown


    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }

    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are throw from the bridge of death!")
        }
    }
}

extension UnladenSwallow {
    var canFly: Bool {
        self != .unknown
    }
}

UnladenSwallow.unknown.canFly
UnladenSwallow.african.canFly
UnladenSwallow.european.airspeedVelocity
Penguin(name: "King Penguin").canFly

//Test the custom string convertible
UnladenSwallow.african

//MARK: - Motorcycle
///This class has nothing to do with birds or flying. You just want to race motorcycles against penguins. It’s time to bring these wacky racers to the starting line.

class Motorcycle {
    var name: String
    var speed: Double

    init(name: String) {
        self.name = name
        speed = 200.0
    }
}

//MARK: - Define protocol for racing
protocol Racer {
    var speed: Double { get }
}

extension FlappyBird: Racer {
    var speed: Double {
        airspeedVelocity
    }
}

extension SwiftBird: Racer {
    var speed: Double {
        airspeedVelocity
    }
}

extension Penguin: Racer {
    var speed: Double {
        42
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        canFly ? airspeedVelocity : 0.0
    }
}

extension Motorcycle: Racer {}

let racers: [Racer] =
[UnladenSwallow.african,
 UnladenSwallow.european,
 UnladenSwallow.unknown,
 Penguin(name: "King Penguin"),
 SwiftBird(version: 5.1),
 FlappyBird(name: "Fellipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
 Motorcycle(name: "Giacomo")
]

Penguin(name: "King Penguin").speed
FlappyBird(name: "Fellipe", flappyAmplitude: 3.0, flappyFrequency: 20.0).speed

//MARK: - Top Speed
///It’s time to write a function that determines the top speed of the racers

func topSpeed(of racers: [Racer]) -> Double {
    racers.max(by: {$0.speed < $1.speed})?.speed ?? 0.0
}

topSpeed(of: racers)

///Find the top speed for a subset of the Racers

func topSpeed<RacersType: Sequence>(of racers: RacersType) -> Double
where RacersType.Iterator.Element == Racer {
    racers.max(by: {$0.speed < $1.speed})?.speed ?? 0.0
}

topSpeed(of: racers[1...3])

///Here's a secret: You can do even better way to find top speed.

extension Sequence where Iterator.Element == Racer {
    func topSpeed() -> Double {
        self.max(by: {$0.speed < $1.speed})?.speed ?? 0.0
    }
}

racers.topSpeed()
racers[1...3].topSpeed()

//MARK: - Protocol Comparators
///You want scores to be comparable so you can tell who has the highest score.
protocol Score: Comparable {
    var value: Int { get }
}

struct RacingScore: Score {
    var value: Int

    static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
        lhs.value < rhs.value
    }
}

RacingScore(value: 150) >= RacingScore(value: 130)

//MARK: - Mutating Function
protocol Cheat {
  mutating func boost(_ power: Double)
}

extension SwiftBird: Cheat {
  mutating func boost(_ power: Double) {
    speedFactor += power
  }
}

var swiftBird = SwiftBird(version: 5.0)
swiftBird.boost(3.0)
swiftBird.airspeedVelocity
swiftBird.boost(3.0)
swiftBird.airspeedVelocity

