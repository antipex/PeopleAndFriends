//
//  MutableCollection.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 21/9/20.
//

import Foundation

struct MutableCollection<T>: Collection {

    enum ChangeType {
        case initial
        case added(index: Int)
        case removed(index: Int)
        case updated(index: Int)
    }

    private(set) var collection: [T]
    var changeType: ChangeType

    var startIndex: Int {
        return collection.startIndex
    }
    var endIndex: Int {
        return collection.endIndex
    }

    func index(after i: Int) -> Int {
        return collection.index(after: i)
    }

    subscript(index: Int) -> T {
        get {
            return collection[index]
        }
        set {
            collection[index] = newValue
        }
    }

}
