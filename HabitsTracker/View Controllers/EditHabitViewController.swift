//
//  EditViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 10.01.2023.
//

import UIKit

class EditHabitViewController: UIViewController {

    private let habitsStore = HabitsStore.shared

    var habit: Habit!

    private lazy var chooseTaskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Task Name:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = "HI"
        label.font = .systemFont(ofSize: 18,weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()

    private lazy var chooseColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Change Color:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var colorPicker: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.translatesAutoresizingMaskIntoConstraints = false
        colorWell.supportsAlpha = true
        colorWell.selectedColor = .purple
        return colorWell
    }()

    private lazy var chooseTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Change time:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var everydayTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Everyday at:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var timeField: UITextField = {
        let textField = UITextField()
        timePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        textField.inputView = timePicker
        textField.textColor = UIColor(named: "customPurple")
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.isEnabled = false
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        textField.text = formatter.string(from: timePicker.date)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.layer.cornerRadius = 20
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove Habit", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(removeHabit), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameLabel.text = habit.name
        view.backgroundColor = .systemGray5
        view.addSubview(chooseTaskNameLabel)
        view.addSubview(taskNameLabel)
        view.addSubview(chooseColorLabel)
        view.addSubview(everydayTimeLabel)
        view.addSubview(timeField)
        view.addSubview(colorPicker)
        view.addSubview(chooseTimeLabel)
        view.addSubview(timePicker)
        view.addSubview(removeButton)
        setupNavigationBar()
        setConstraints()
    }

    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeField.text = formatter.string(from: timePicker.date)
    }

    @objc private func removeHabit () {
        showAlert()
    }
}

extension EditHabitViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            chooseTaskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            chooseTaskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            taskNameLabel.topAnchor.constraint(equalTo: chooseTaskNameLabel.bottomAnchor, constant: 2),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 40),

            chooseColorLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 20),
            chooseColorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            colorPicker.topAnchor.constraint(equalTo: chooseColorLabel.bottomAnchor, constant: 4),
            colorPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorPicker.widthAnchor.constraint(equalToConstant: 50),
            colorPicker.heightAnchor.constraint(equalToConstant: 50),

            chooseTimeLabel.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 20),
            chooseTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            everydayTimeLabel.topAnchor.constraint(equalTo: chooseTimeLabel.bottomAnchor, constant: 8),
            everydayTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            timeField.topAnchor.constraint(equalTo: chooseTimeLabel.bottomAnchor, constant: 8),
            timeField.leadingAnchor.constraint(equalTo: everydayTimeLabel.trailingAnchor, constant: 4),

            timePicker.topAnchor.constraint(equalTo: everydayTimeLabel.bottomAnchor, constant: 8),
            timePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            timePicker.heightAnchor.constraint(equalToConstant: 140),

            removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            removeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -26)
        ])
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = "Edit Habit"
        navBarAppearance.backgroundColor = UIColor(cgColor: CGColor(
            red: 247 / 255,
            green: 247 / 255,
            blue: 247 / 255,
            alpha: 0.8)
        )
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "customPurple") ?? .purple]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "customPurple")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(editDidTapped)
        )
    }

    @objc private func editDidTapped() {
        guard let name = taskNameLabel.text else { return }
        guard let color = colorPicker.selectedColor else { return }

        let newHabit = Habit(
            name: name,
            date: timePicker.date,
            color: color
        )

        for (index, storageHabit) in habitsStore.habits.enumerated() {
            if storageHabit.name == habit?.name {
                newHabit.trackDates = storageHabit.trackDates
                habitsStore.habits[index] = newHabit
                habit? = newHabit
            }
        }

        navigationController?.popToRootViewController(animated: true)
    }

    private func showAlert() {
        let store = HabitsStore.shared
        let alert = UIAlertController(
            title: "Removing habit",
            message: "Do you want to remove habit \(taskNameLabel.text ?? "")?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            for (index, storageHabit) in store.habits.enumerated() {
                if storageHabit.name == self.habit?.name {
                    store.habits.remove(at: index)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }))
        present(alert, animated: true)
    }
}
