//
//  ProgressCollectionViewHeader.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 01.01.2023.
//

import UIKit

class ProgressCollectionViewHeader: UICollectionReusableView {

    static let identifier = "ProgressCollectionViewHeader"

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
        return progressView
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customBack")
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

    func setupHeader(with store: HabitsStore) {
        self.percentText.text = (store.todayProgress * 100).formatted() + "%"
        self.habitsProgressBar.setProgress(store.todayProgress, animated: true)
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
