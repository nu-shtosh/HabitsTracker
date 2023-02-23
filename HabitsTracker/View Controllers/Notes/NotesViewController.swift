//
//  TasksViewController.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 03.02.2023.
//

import UIKit

class NotesViewController: UIViewController {

    private var fetchedResultsController = StorageManager.shared.getFetchedResultsController(
        entityName: "Note",
        keyForSort: "date"
    )

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(
            width: view.frame.size.width,
            height: view.frame.size.height / 5.5
        )

        layout.minimumInteritemSpacing = 60
        layout.minimumLineSpacing = 60

        layout.sectionInset = UIEdgeInsets.init(
            top: 0,
            left: 0,
            bottom: 80,
            right: 0
        )

        return layout
    }()

    private lazy var notesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(
            NoteCollectionViewCell.self,
            forCellWithReuseIdentifier: NoteCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupNavigationBar()
        view.addSubview(notesCollectionView)
        setConstraints()
        notesCollectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchNotes()
        notesCollectionView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        notesCollectionView.reloadData()
    }

    private func fetchNotes() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
}

extension NotesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

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

extension NotesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let note = fetchedResultsController.object(at: indexPath) as? Note
        let noteDetailVC = NoteDetailViewController()
        noteDetailVC.hidesBottomBarWhenPushed = true

        noteDetailVC.note = note
        navigationController?.pushViewController(noteDetailVC, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dequeuedCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NoteCollectionViewCell.identifier,
            for: indexPath
        )
        guard let cell = dequeuedCell as? NoteCollectionViewCell else {
            fatalError("Wrong cell type for section 0. Expected CellType")
        }
        let note = fetchedResultsController.object(at: indexPath) as? Note
        cell.noteTitle.text = note?.title
        if note?.priority == 0 {
            cell.notePriority.tintColor = .systemGreen
        } else if note?.priority == 1 {
            cell.notePriority.tintColor = .systemYellow
        } else if note?.priority == 2 {
            cell.notePriority.tintColor = .systemRed
        } else if note?.priority == 3 {
            cell.notePriority.tintColor = .gray
        }
        cell.noteText.text = note?.text
        return cell
    }
}
