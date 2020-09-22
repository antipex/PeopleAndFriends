//
//  PersonIconView.swift
//  PeopleAndFriends
//
//  Created by Kyle Rohr on 22/9/20.
//

import UIKit

class PersonIconView: UIView {

    struct Metrics {
        static let circleViewPadding: CGFloat = 4
    }

    var initialsLabel = UILabel()

    private let circleView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupSubviews()
    }

    private func setupSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        initialsLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(circleView)

        circleView.backgroundColor = .lightGray

        circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.circleViewPadding).isActive = true
        circleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.circleViewPadding).isActive = true
        circleView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.circleViewPadding).isActive = true
        circleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.circleViewPadding).isActive = true

        circleView.addSubview(initialsLabel)

        initialsLabel.leadingAnchor.constraint(equalTo: circleView.leadingAnchor).isActive = true
        initialsLabel.trailingAnchor.constraint(equalTo: circleView.trailingAnchor).isActive = true
        initialsLabel.topAnchor.constraint(equalTo: circleView.topAnchor).isActive = true
        initialsLabel.bottomAnchor.constraint(equalTo: circleView.bottomAnchor).isActive = true

        initialsLabel.textAlignment = .center
        initialsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        circleView.layer.cornerRadius = (frame.height - (Metrics.circleViewPadding * 2)) / 2
    }

}
