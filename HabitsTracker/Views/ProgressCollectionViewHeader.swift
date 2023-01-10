//
//  ProgressCollectionViewHeader.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 01.01.2023.
//

import UIKit

class ProgressCollectionViewHeader: UICollectionReusableView {

    static let identifier = "ProgressCollectionViewHeader"

    private let habitsStore = HabitsStore.shared

    private lazy var motivationText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "У тебя все получится!"
        textLabel.textColor = .lightGray
        textLabel.font = .systemFont(ofSize: 14, weight: .bold)
        return textLabel
    }()

    private lazy var percentText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = (habitsStore.todayProgress * 100).formatted() + "%"
        textLabel.textColor = .lightGray
        textLabel.font = .systemFont(ofSize: 14, weight: .bold)
        return textLabel
    }()

    private lazy var habitsProgressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .systemGray4
        progressView.clipsToBounds = true
        progressView.tintColor = UIColor(named: "customPurple")
        progressView.layer.cornerRadius = 3
        progressView.setProgress(habitsStore.todayProgress, animated: true)
        return progressView
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
        view.addSubview(motivationText)
        view.addSubview(percentText)
        view.addSubview(habitsProgressBar)
        view.layer.cornerRadius = 20
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProgressCollectionViewHeader {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backView.heightAnchor.constraint(equalToConstant: 70),

            motivationText.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            motivationText.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),

            percentText.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            percentText.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),

            habitsProgressBar.topAnchor.constraint(equalTo: motivationText.bottomAnchor, constant: 10),
            habitsProgressBar.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            habitsProgressBar.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            habitsProgressBar.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
}
