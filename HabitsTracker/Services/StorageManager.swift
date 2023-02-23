//
//  StorageManager.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 17.02.2023.
//

import CoreData

class StorageManager {

    static let shared: StorageManager = .init()

    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HabitsTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

        })
        return container
    }()

    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    func getFetchedResultsController(entityName: String,
                                     keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchResultsController = NSFetchedResultsController<NSFetchRequestResult>(
            fetchRequest: fetchRequest,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        return fetchResultsController
    }

    func createNote(withTitle title: String,
                  text: String,
                  andPriority priority: Int16) {
        let note = Note(context: viewContext)
        note.title = title
        note.text = text
        note.priority = priority
        note.date = Date()
        saveContext()
    }

    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        saveContext()
    }

    func updateNote(_ note: Note,
                    withTitle newTitle: String,
                    text: String,
                    and priority: Int16) {
        note.title = newTitle
        note.priority = priority
        saveContext()
    }
    
}
