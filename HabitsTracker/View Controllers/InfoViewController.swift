//
//  InfoViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 01.01.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.addSubview(habitsText)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: .zero, height: UIScreen.main.bounds.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var habitsText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.text = "21 Day Habit  \n \nThe passage of the stages for which a habit is developed in 21 days is subject to the following algorithm: \n \n1. Spend one day without reverting to old habits, try to act as if the goal is in perspective, to be within walking distance. \n \n2. Maintain 2 days in the same state of self-control. \n \n3. Mark in the diary the first week of changes and sum up the first results - what turned out to be difficult, what was easier, what still has to be seriously fought. \n \n4. Congratulate yourself on passing your first major threshold at 21 days. During this time, the rejection of bad inclinations will already take the form of a conscious overcoming and a person will be able to work more towards the adoption of positive qualities. \n \n5. Hold the plank for 40 days. The practitioner of the technique already feels freed from past negativity and is moving in the right direction with good dynamics. \n \n6. On the 90th day of observing the technique, everything superfluous from the “past life” ceases to remind of itself, and a person, looking back, realizes himself completely renewed."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubview(scrollView)
        setupScrollView()
    }
    
    private func setupScrollView(){
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            habitsText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            habitsText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            habitsText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            habitsText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),

        ])
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = "Information"
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
        navigationController?.navigationBar.layer.borderColor = UIColor.black.cgColor
    }

}
