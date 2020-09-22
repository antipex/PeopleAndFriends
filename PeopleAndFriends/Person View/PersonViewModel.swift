//
//  PersonViewModel.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 21/9/20.
//

import Foundation
import Combine

class PersonViewModel: NSObject {

    var person: Person

    init(person: Person) {
        self.person = person

        super.init()
    }

}
