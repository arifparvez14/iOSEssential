import UIKit

//MARK: - Reduce
var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

var evenSum = 0
for i in evens {
  evenSum += i
}

//print(evenSum)

//MARK: - Functional reduce
evenSum = Array(1...10)
    .filter{ (number) in number % 2 == 0 }
    .reduce(0) { (total, number) in total + number }

//print(evenSum)


let maxNumber = Array(1...10)
    .reduce(0){ (total, number) in max (total, number) }
//print(maxNumber)

//func reduce<U>(initial: U, combine: (U, T) -> U) -> U

let numbers = Array(1...10)
    .reduce("number: ") {(total, number) in total + "\(number) "}
//print(numbers)

//MARK: - The Magic Behind Reduce
extension Array {
    func myReduce<T, U>(seed: U, combine: (U, T) -> U) -> U {
        var current = seed
        for item in self {
            current = combine(current, item as! T)
        }
        return current
    }
}

let myNumbers = Array(1...10).myReduce(seed: 0){ (total, number) in max (total, number) }
print(myNumbers)

