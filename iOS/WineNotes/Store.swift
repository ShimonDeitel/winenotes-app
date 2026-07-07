import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [Wine] = []
    @Published var categoryFilters: Set<String> = []

    /// Free-tier item limit. Kept comfortably above seed data count so a fresh
    /// install never hits the paywall immediately.
    static let freeLimit = 20

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("winenotes", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("items.json")
        load()
        if items.isEmpty {
            seed()
            save()
        }
    }

    var isAtFreeLimit: Bool {
        items.count >= Self.freeLimit
    }

    func canAdd(isPro: Bool) -> Bool {
        isPro || items.count < Self.freeLimit
    }

    func add(_ item: Wine) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Wine) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Wine) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func seed() {
        items = Self.seedData()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([Wine].self, from: data) {
            items = decoded
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    private static func seedData() -> [Wine] {
        [Wine(), Wine(), Wine()]
    }
}
