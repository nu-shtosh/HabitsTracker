//
//  HabitCollectionViewCell.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 01.01.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    static let identifier = "HabitCollectionViewCell"

    var habit: Habit? {
        didSet {
            dateText.text = habit?.dateString
            taskText.text = habit?.name
            taskText.textColor = habit?.color
            counterText.text = "Counter: \(habit?.trackDates.count ?? 0)"
            imageGestureSettings(imageView: checkmark, and: habit)
            if ((habit?.isAlreadyTakenToday) == true) {
                checkmark.image = UIImage(systemName: "checkmark.circle.fill")
            } else {
                checkmark.image = UIImage(systemName: "circle")
            }
            checkmark.tintColor = habit?.color
        }
    }


    private lazy var counterText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "counter"
        textLabel.textColor = .gray
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return textLabel
    }()

    private lazy var dateText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "date"
        textLabel.textColor = .gray
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return textLabel
    }()

    private lazy var taskText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "task"
        textLabel.textColor = .purple
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return textLabel
    }()

    private lazy var checkmark: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .red

        return imageView
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(
            red: 247 / 255,
            green: 247 / 255,
            blue: 247 / 255,
            alpha: 0.8)
        )

        view.addSubview(checkmark)
        view.addSubview(taskText)
        view.addSubview(dateText)
        view.addSubview(counterText)
        view.layer.cornerRadius = 20
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backView)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HabitCollectionViewCell {
    private func imageGestureSettings(imageView: UIImageView, and habit: Habit?) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkmarkDidTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }

    @objc private func checkmarkDidTapped() {

    }
}
extension HabitCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backView.heightAnchor.constraint(equalToConstant: 140),

            checkmark.widthAnchor.constraint(equalToConstant: 50),
            checkmark.heightAnchor.constraint(equalToConstant: 50),
            checkmark.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            checkmark.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),

            taskText.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            taskText.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            taskText.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -40),

            dateText.topAnchor.constraint(equalTo: taskText.bottomAnchor,constant: 5),
            dateText.leadingAnchor.constraint(equalTo: backView.leadingAnchor,constant: 16),

            counterText.leadingAnchor.constraint(equalTo: backView.leadingAnchor,constant: 16),
            counterText.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: -16),
        ])
    }
}
