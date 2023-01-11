//
//  HabitDetailViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 03.01.2023.
//

import UIKit

class HabitDetailViewController: UIViewController {

    var habit: Habit?

    private let habitDetailTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        tableView.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        return tableView
    }()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru-RU")
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(habitDetailTableView)
        habitDetailTableView.delegate = self
        habitDetailTableView.dataSource = self
        setConstraints()
        setupNavigationBar()
    }
}

extension HabitDetailViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            habitDetailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            habitDetailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitDetailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitDetailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = habit?.name
        navBarAppearance.backgroundColor = UIColor(named: "customBack")
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "customPurple")
        navigationController?.navigationBar.layer.borderColor = UIColor.black.cgColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(editDidTapped)
        )
    }

    @objc private func editDidTapped() {
        let editHabitVC = EditHabitViewController()
        editHabitVC.hidesBottomBarWhenPushed = true
        editHabitVC.habit = habit
        navigationController?.show(editHabitVC, sender: .none)
    }
}

extension HabitDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(
            withIdentifier: DateTableViewCell.identifier,
            for: indexPath
        )
        guard let cell = dequeuedCell as? DateTableViewCell else {
            fatalError("Wrong cell type for section 0. Expected CellType")
        }

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.dateLabel.text = dateFormatter.string(
            from: HabitsStore.shared.dates[HabitsStore.shared.dates.count - indexPath.row - 1]
        )

        if let isHabit = habit {
            let isTracked = HabitsStore.shared.habit(
                isHabit,
                isTrackedIn: HabitsStore.shared.dates[HabitsStore.shared.dates.count - indexPath.row - 1]
            )
            if isTracked {
                cell.accessoryType = .checkmark
                cell.tintColor = UIColor(named: "customPurple")
            }
        }
        return cell
    }
}
