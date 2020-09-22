//
//  PersonListViewModel.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 21/9/20.
//

import Foundation
import Combine

class PersonListViewModel: NSObject {

    @Published var people = PersonCollection(collection: [], changeType: .initial)

    private var personApi: PersonApiImpl

    private var cancellables = Set<AnyCancellable>()

    init(personApi: PersonApiImpl) {
        self.personApi = personApi

        super.init()
    }

    func reload() {
        Publishers.Zip(personApi.getPeople(), personApi.getFriendLists())
            .sink { completion in
                switch completion {
                case .failure(let apiError):
                    switch apiError {
                    case .sessionError(let error):
                        print("Session error: \(error.localizedDescription)")
                    case .decodingError(let error):
                        print("Decoding error: \(error.localizedDescription)")
                    default:
                        print("An unknown error occurred")
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] values in
                let people = values.0.map { person -> Person in
                    var mutablePerson = person

                    let friendList = values.1.first(where: { $0.personId == person.id })

                    mutablePerson.friends = friendList?.friends ?? []

                    return mutablePerson
                }

                self?.people = PersonCollection(collection: people, changeType: .initial)
            }
            .store(in: &cancellables)
    }

}
