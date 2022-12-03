import UIKit

protocol Entity {
    var name: String {get set}
    static func uuid() -> String
}

//MARK: - Protocol Extension
extension Entity {
    static func uuid() -> String {
        return UUID().uuidString
    }
}

struct Order: Entity {
    var name: String
    let uuid: String = Order.uuid()
}

let order = Order(name: "My order")
print(order.uuid)

//MARK: - Protocol Inheritance
protocol Persistable: Entity {
    func write(instance: Entity, to filePath: String)
}

struct PersistableEntity: Persistable {
    var name: String
    func write(instance: Entity, to filePath: String) {
        print("Write method")
    }
}

//MARK: - Protocol Composition
struct MyEntity: Entity, Equatable, CustomStringConvertible {
    //Entity
    var name: String

    //Equatable
    public static func ==(lhs: MyEntity, rhs: MyEntity) -> Bool {
        return lhs.name == rhs.name
    }

    //CustomStringConvertible
    var description: String {
        return "MyEntity: \(name)"
    }
}

let entity1 = MyEntity(name: "42")
print(entity1)

let entity2 = MyEntity(name: "43")
//assert(entity1 == entity2, "Entities shall be equal")

entity1 == entity2 ? (print("Entities are equal")) : (print("Entities are not equal "))


