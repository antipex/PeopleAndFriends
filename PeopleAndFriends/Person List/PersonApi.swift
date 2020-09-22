//
//  PersonApi.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 21/9/20.
//

import Foundation
import Combine

enum PersonApiError: Error {
    case invalidUrl
    case sessionError(error: Error)
    case decodingError(error: Error)
}

protocol PersonApiImpl {

    func getPeople() -> AnyPublisher<[Person], PersonApiError>
    func getFriendLists() -> AnyPublisher<[FriendList], PersonApiError>

}

class PersonApi: PersonApiImpl {

    func getPeople() -> AnyPublisher<[Person], PersonApiError> {
        let url = URL(string: Constants.Files.people)!

        let decoder = JSONDecoder()

        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .mapError({ error -> PersonApiError in
                PersonApiError.sessionError(error: error)
            })
            .decode(type: [Person].self, decoder: decoder)
            .mapError({ error -> PersonApiError in
                PersonApiError.decodingError(error: error)
            })
            .eraseToAnyPublisher()
    }

    func getFriendLists() -> AnyPublisher<[FriendList], PersonApiError> {
        let url = URL(string: Constants.Files.friends)!

        let decoder = JSONDecoder()

        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
            .mapError({ error -> PersonApiError in
                PersonApiError.sessionError(error: error)
            })
            .decode(type: [FriendList].self, decoder: decoder)
            .mapError({ error -> PersonApiError in
                PersonApiError.decodingError(error: error)
            })
            .eraseToAnyPublisher()
    }

}
