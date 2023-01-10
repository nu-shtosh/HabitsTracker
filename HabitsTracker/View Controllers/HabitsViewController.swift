//
//  HabitsViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 01.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    private var habitsStore = HabitsStore.shared

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(
            width: view.frame.size.width,
            height: view.frame.size.height / 5.5
        )
        layout.sectionInset = UIEdgeInsets.init(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        return layout
    }()

    private lazy var habitsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        collectionView.register(
            ProgressCollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProgressCollectionViewHeader.identifier
        )
        collectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubview(habitsCollectionView)
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        habitsCollectionView.reloadData()
    }
}

extension HabitsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = "Habits"
        navBarAppearance.backgroundColor = UIColor(named: "customBack")
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "customPurple") ?? .purple]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = UIColor(named: "customPurple")
        navigationItem.backButtonTitle = "Cancel"
        navigationController?.navigationBar.layer.borderColor = UIColor.black.cgColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addDidTapped)
            )
    }

    @objc private func addDidTapped() {
        let addHabitVC = AddHabitViewController()
        addHabitVC.hidesBottomBarWhenPushed = true
        navigationController?.show(addHabitVC, sender: .none)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        habitsStore.habits.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let habitDetailVC = HabitDetailViewController()
        habitDetailVC.habit = habitsStore.habits[indexPath.row]
        navigationController?.pushViewController(habitDetailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let dequeuedHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProgressCollectionViewHeader.identifier,
            for: indexPath
        )
        guard let header = dequeuedHeader as? ProgressCollectionViewHeader else {
            fatalError("Wrong header type for section 0. Expected HeaderType")
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HabitCollectionViewCell.identifier,
            for: indexPath
        )
        guard let cell = dequeuedCell as? HabitCollectionViewCell else {
            fatalError("Wrong cell type for section 0. Expected CellType")
        }
        let habit = habitsStore.habits[indexPath.item]
        cell.habit = habit
        return cell
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
}
