//
//  PersonListViewController.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 21/9/20.
//

import UIKit
import Combine

class PersonListViewController: UITableViewController {

    private let reuseIdentifier = "PersonCell"

    var viewModel: PersonListViewModel!

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = PersonListViewModel(personApi: PersonApi())

        viewModel.$people.receive(on: DispatchQueue.main)
            .sink { people in
            switch people.changeType {
            case .initial:
                self.tableView.reloadData()
            case .added(let index):
                self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            case .updated(let index):
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            case .removed(let index):
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        }.store(in: &cancellables)

        viewModel.reload()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PersonListCell
        let person = viewModel.people[indexPath.row]

        cell.iconView.initialsLabel.text = person.name.initials
        cell.nameLabel.text = person.name.full

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PersonViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            vc.person = viewModel.people[selectedIndexPath.row]
        }
    }

}
