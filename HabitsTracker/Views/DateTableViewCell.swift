//
//  DateTableViewCell.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 10.01.2023.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    static let identifier = "DateTableViewCell"

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DateTableViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 11),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -11)
        ])
    }
}
