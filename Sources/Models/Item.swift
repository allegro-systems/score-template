import Foundation
import os

/// A simple model representing an item.
struct Item: Codable, Sendable {
    let id: UUID
    let title: String
    let description: String
}

/// Thread-safe in-memory item store, seeded with sample data.
final class ItemStore: Sendable {
    static let shared = ItemStore()

    private let storage = OSAllocatedUnfairLock<[UUID: Item]>(
        initialState: {
            var dict: [UUID: Item] = [:]
            for item in Item.samples {
                dict[item.id] = item
            }
            return dict
        }())

    func all() -> [Item] {
        storage.withLock { Array($0.values) }
    }

    func add(_ item: Item) {
        storage.withLock { $0[item.id] = item }
    }

    @discardableResult
    func update(_ item: Item) -> Bool {
        storage.withLock { store in
            guard store[item.id] != nil else { return false }
            store[item.id] = item
            return true
        }
    }

    @discardableResult
    func remove(_ id: UUID) -> Bool {
        storage.withLock { $0.removeValue(forKey: id) != nil }
    }
}

extension Item {
    static let samples: [Item] = {
        // Static UUIDs for stable sample data
        guard
            let id1 = UUID(uuidString: "00000000-0000-0000-0000-000000000001"),
            let id2 = UUID(uuidString: "00000000-0000-0000-0000-000000000002"),
            let id3 = UUID(uuidString: "00000000-0000-0000-0000-000000000003")
        else { return [] }
        return [
            Item(id: id1, title: "Pages", description: "Declarative pages with result builders."),
            Item(id: id2, title: "Components", description: "Reactive UI with @State and @Action."),
            Item(id: id3, title: "Routes", description: "Type-safe routing with path parameters."),
        ]
    }()
}
