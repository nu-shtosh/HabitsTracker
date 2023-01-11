//
//  AddHabitViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 02.01.2023.
//

import UIKit

class AddHabitViewController: UIViewController {

    private let habitsStore = HabitsStore.shared

    private lazy var chooseTaskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var taskNameTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.layer.masksToBounds = true
        textField.placeholder = "Пить воду, бегать, смотреть кино в 21:00..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var chooseColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цвет"
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
        label.text = "Время"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var everydayTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в: "
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        view.addSubview(chooseTaskNameLabel)
        view.addSubview(taskNameTextField)
        view.addSubview(chooseColorLabel)
        view.addSubview(everydayTimeLabel)
        view.addSubview(timeField)
        view.addSubview(colorPicker)
        view.addSubview(chooseTimeLabel)
        view.addSubview(timePicker)
        setupNavigationBar()
        setConstraints()
    }

    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeField.text = formatter.string(from: timePicker.date)
    }
}

extension AddHabitViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            chooseTaskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            chooseTaskNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            taskNameTextField.topAnchor.constraint(equalTo: chooseTaskNameLabel.bottomAnchor, constant: 8),
            taskNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            taskNameTextField.heightAnchor.constraint(equalToConstant: 40),

            chooseColorLabel.topAnchor.constraint(equalTo: taskNameTextField.bottomAnchor, constant: 20),
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
            timePicker.heightAnchor.constraint(equalToConstant: 140)
        ])
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = "Добавить"
        navBarAppearance.backgroundColor = UIColor(named: "customBack")
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "customPurple") ?? .purple]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "customPurple")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(saveDidTapped)
        )
    }

    @objc private func saveDidTapped() {
        guard let name = taskNameTextField.text else { return }
        guard let color = colorPicker.selectedColor else { return }
        if name != "" {
            habitsStore.habits.append(
                Habit(name: name,
                      date: timePicker.date,
                      color: color)
            )
            navigationController?.popToRootViewController(animated: true)
        } else {

        }
    }
}
