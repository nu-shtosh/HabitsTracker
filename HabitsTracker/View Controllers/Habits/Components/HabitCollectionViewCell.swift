//
//  HabitCollectionViewCell.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 01.01.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    static let identifier = "HabitCollectionViewCell"

    private let checkedImage = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
    private let uncheckedImage = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)

    private var habit: Habit!
    private var onStateButtonClick: (() -> Void)!

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

    private lazy var habitText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "task"
        textLabel.textColor = .purple
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return textLabel
    }()

    private lazy var checkmark: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(checkmarkDidTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(checkedImage, for: .normal)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        return button
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 1
        view.addSubview(checkmark)
        view.addSubview(habitText)
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

    func setupCell(with habit: Habit, onStateButtonClick: @escaping () -> Void) {
        self.habit = habit
        self.onStateButtonClick = onStateButtonClick

        dateText.text = habit.dateString

        habitText.text = habit.name
        habitText.textColor = habit.color

        counterText.text = "Счетчик: \(habit.trackDates.count)"

        if habit.isAlreadyTakenToday {
            checkmark.setImage(checkedImage, for: .normal)
        } else {
            checkmark.setImage(uncheckedImage, for: .normal)
        }
        checkmark.tintColor = habit.color
    }

    @objc func checkmarkDidTapped() {
        if !habit.isAlreadyTakenToday {
            checkmark.setImage(checkedImage, for: .normal)
            HabitsStore.shared.track(habit)
            onStateButtonClick()
        }
    }
}

extension HabitCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backView.heightAnchor.constraint(equalToConstant: 110),

            checkmark.widthAnchor.constraint(equalToConstant: 50),
            checkmark.heightAnchor.constraint(equalToConstant: 50),
            checkmark.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            checkmark.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12),

            habitText.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
            habitText.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),
            habitText.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -40),

            dateText.topAnchor.constraint(equalTo: habitText.bottomAnchor,constant: 4),
            dateText.leadingAnchor.constraint(equalTo: backView.leadingAnchor,constant: 12),

            counterText.leadingAnchor.constraint(equalTo: backView.leadingAnchor,constant: 12),
            counterText.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: -12),
        ])
    }
}
