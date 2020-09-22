//
//  PersonViewController.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 21/9/20.
//

import UIKit

class PersonViewController: UIViewController {

    var person: Person?
    private var viewModel: PersonViewModel!

    private let reuseIdentifier = "FriendCell"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        if let person = person {
            viewModel = PersonViewModel(person: person)

            title = viewModel.person.name.full
            companyLabel.text = viewModel.person.company
            emailLabel.text = viewModel.person.email
            addressLabel.text = viewModel.person.address

            tableView.reloadData()
        }
    }

}

extension PersonViewController: UITableViewDelegate {



}

extension PersonViewController: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.person.friends?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!

        if let friends = viewModel.person.friends {
            cell.textLabel?.text = friends[indexPath.row].name.full
        }

        return cell
    }

}
