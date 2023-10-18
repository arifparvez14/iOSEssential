//
//  CartManager.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 18/10/23.
//


import Foundation

protocol Product {
    var movieItem: MovieResult { get }
    func isEqual(to product: Product) -> Bool
}

extension Product {

    func isEqual(to product: Product) -> Bool {
        return movieItem.id == product.movieItem.id
    }
}

struct movieProduct: Product {
    var movieItem: MovieResult
}

protocol CartSubscriber {
    func accept(changed cartCount: Int)
}

final class CartManager {

    static let sharedInstance = CartManager()

    private init() {}

    private lazy var cart = [MovieResult]()
    private lazy var subscribers = [CartSubscriber]()

    func add(subscriber: CartSubscriber) {
        subscribers.append(subscriber)
    }

    func add(movieResult: MovieResult) {
        cart.append(movieResult)
        notifySubscribers()
    }

    func remove(subscriber filter: (CartSubscriber) -> (Bool)){
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }

    func remove(movieResult: MovieResult) {
        guard let index = cart.firstIndex(where: { $0.id == movieResult.id }) else { return }
        cart.remove(at: index)
        notifySubscribers()
    }

    private func notifySubscribers() {
        subscribers.forEach { subs in
            subs.accept(changed: cart.count)
        }
    }
}
