//
//  Note.swift
//  HabitsTracker
//
//  Created by Илья Дубенский on 03.02.2023.
//

import Foundation

struct Note: Codable {
    var name: String
    var description: String
    var priority: String
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.priority == rhs.priority
    }
}

final class NotesStore {

    static let shared: NotesStore = .init()

    var notes: [Note] = [] {
        didSet {
            save()
        }
    }

    private lazy var userDefaults: UserDefaults = .standard

    private lazy var decoder: JSONDecoder = .init()

    private lazy var encoder: JSONEncoder = .init()

    func save() {
        do {
            let data = try encoder.encode(notes)
            userDefaults.setValue(data, forKey: "notes")
        }
        catch {
            print("Ошибка кодирования заметок для сохранения", error)
        }
    }
}
