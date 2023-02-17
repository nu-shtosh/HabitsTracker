//
//  TasksViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 03.02.2023.
//

import UIKit

class NotesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupNavigationBar()
    }
}

extension NotesViewController {
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        title = "Заметки"
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .purple
        navigationController?.navigationBar.layer.borderColor = UIColor.black.cgColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        navigationItem.backButtonTitle = "Отменить"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Создать",
            style: .plain,
            target: self,
            action: #selector(addDidTapped)
        )
    }

    @objc func addDidTapped() {
        let addNoteVC = AddNoteViewController()
        addNoteVC.hidesBottomBarWhenPushed = true
        navigationController?.show(addNoteVC, sender: .none)
    }
}
