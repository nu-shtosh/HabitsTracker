//
//  AddNoteViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 03.02.2023.
//

import UIKit

class AddNoteViewController: UIViewController {

    private let notesStore = NotesStore.shared

    private lazy var noteNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var noteNameTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.layer.masksToBounds = true
        textField.placeholder = "Идеи, список покупок, просмотренные фильмы..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var noteDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var noteDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white

        textView.text = "Купить молоко, посмотреть фильм \"Человек паук\", сделать приложение..."

        textView.font = .systemFont(ofSize: 14)
        textView.layer.cornerRadius = 12
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 1

        textView.textColor = UIColor.systemGray3

        textView.isSelectable = true
        textView.isEditable = true
        return textView
    }()

    private lazy var notePriorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Важность"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var notePrioritySegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["!", "!!", "!!!"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.layer.borderWidth = 1
        segmentControl.layer.borderColor = UIColor.systemGray3.cgColor
        segmentControl.selectedSegmentTintColor = .red
        return segmentControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        addSubviews()
        setConstraints()
        setupNavigationBar()
    }
}

extension AddNoteViewController {
    private func setupMainView() {
        self.noteDescriptionTextView.delegate = self
        view.backgroundColor = .systemGray6
    }

    private func addSubviews() {
        view.addSubview(noteNameLabel)
        view.addSubview(noteNameTextField)
        view.addSubview(noteDescriptionLabel)
        view.addSubview(noteDescriptionTextView)
        view.addSubview(notePriorityLabel)
        view.addSubview(notePrioritySegmentControl)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            noteNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            noteNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            noteNameTextField.topAnchor.constraint(equalTo: noteNameLabel.bottomAnchor, constant: 8),
            noteNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            noteNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            noteNameTextField.heightAnchor.constraint(equalToConstant: 40),

            noteDescriptionLabel.topAnchor.constraint(equalTo: noteNameTextField.bottomAnchor, constant: 16),
            noteDescriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            noteDescriptionTextView.topAnchor.constraint(equalTo: noteDescriptionLabel.bottomAnchor, constant: 8),
            noteDescriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            noteDescriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            noteDescriptionTextView.heightAnchor.constraint(equalToConstant: 160),

            notePriorityLabel.topAnchor.constraint(equalTo: noteDescriptionTextView.bottomAnchor, constant: 16),
            notePriorityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            notePrioritySegmentControl.topAnchor.constraint(equalTo: notePriorityLabel.bottomAnchor, constant: 8),
            notePrioritySegmentControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            notePrioritySegmentControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = "Добавить заметку"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .purple
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(saveDidTapped)
        )
    }

    @objc func saveDidTapped() {
        guard let name = noteNameTextField.text else { return }
//        guard let description = noteDescriptionTextView.text else { return }
//        guard let priority = notePrioritySegmentControl.selectedSegmentIndex else { return }
        if name != "" {
            navigationController?.popToRootViewController(animated: true)
        } else {
            noteNameTextField.placeholder = "У заметки должно быть название..."
            noteNameTextField.shake()
        }
    }
}

extension AddNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray3 {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Купить молоко, посмотреть фильм \"Человек паук\", сделать приложение..."
            textView.textColor = UIColor.systemGray3
        }
    }
}

// MARK: - Hide Keyboard
extension AddNoteViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
