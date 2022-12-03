import UIKit

///Functional programming is a programming paradigm that emphasizes calculations via mathematical-style functions, immutability and expressiveness, and minimizes the use of variables and state.

///Since there’s minimal shared state and each function is like an island in the ocean of your app, it makes things easier to test. Functional programming has also come into popularity because it can make concurrency and parallel processing easier to work with.
///

//MARK: - Simple Array Filtering
//Traditional way
var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

//imperative version
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}
//print(evens)

evens = Array(1...10).filter(isEven)

//More concise version
evens = Array(1...10).filter { (number) in number % 2 == 0 }
//print(evens)

//one step further
evens = Array(1...10).filter{ $0 % 2 == 0}
print(evens)


//MARK: - The Magic Behind Filter
func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}

evens = myFilter(source: Array(1...10)) { $0 % 2 == 0 }
print(evens)

//MARK: - Reducing

