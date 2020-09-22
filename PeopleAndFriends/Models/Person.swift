//
//  Person.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 21/9/20.
//

import Foundation

typealias PersonCollection = MutableCollection<Person>

struct Name: Codable {

    var first: String
    var last: String

    var full: String {
        return first + " " + last
    }

    var initials: String {
        let formatter = PersonNameComponentsFormatter()

        formatter.style = .abbreviated

        guard let components = formatter.personNameComponents(from: full) else { return "" }

        return formatter.string(from: components)
    }

    enum CodingKeys: String, CodingKey {
        case first
        case last
    }

}

struct FriendList: Codable {

    var personId: String
    var friends: [Friend]

}

struct Friend: Codable {

    var id: Int
    var name: Name

}

struct Person: Codable {

    var id: String
    var index: Int
    var guid: String
    var isActive: Bool
    var balance: String
    var picture: String
    var age: Int
    var name: Name
    var company: String
    var email: String
    var phone: String
    var address: String
    var about: String

    var friends: [Friend]?

    enum CodingKeys: String, CodingKey {
        case id
        case index
        case guid
        case isActive
        case balance
        case picture
        case age
        case name
        case company
        case email
        case phone
        case address
        case about
    }

}
