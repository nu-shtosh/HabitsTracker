//
//  NoteCollectionViewCell.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 17.02.2023.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {

    static let identifier = "NoteCollectionViewCell"

    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()

    lazy var noteTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()

    lazy var notePriority: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        return imageView
    }()

    lazy var noteText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 14, weight: .regular)

        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray5.cgColor

        textView.isEditable = false
        textView.isSelectable = true
        return textView
    }()

    private lazy var editNoteText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Редактировать"
        textLabel.textColor = .purple
        textLabel.font = .systemFont(ofSize: 11, weight: .regular)
        return textLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backView)
        backView.addSubview(noteTitle)
        backView.addSubview(notePriority)
        backView.addSubview(noteText)
        backView.addSubview(editNoteText)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backView.heightAnchor.constraint(equalToConstant: 200),

            noteTitle.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
            noteTitle.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),

            editNoteText.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 6),
            editNoteText.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12),

            notePriority.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
            notePriority.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12),

            noteText.topAnchor.constraint(equalTo: editNoteText.bottomAnchor, constant: 6),
            noteText.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            noteText.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            noteText.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -6),
        ])
    }
}
