import Foundation
import SwiftUI

@MainActor
final class WorkStore: ObservableObject {
    @Published private(set) var works: [ChatWork] = []

    private let key = "screenshot_theater_works_v1"

    init() {
        load()
    }

    func save(_ work: ChatWork) {
        var newWork = work
        newWork.createdAt = Date()

        if let index = works.firstIndex(where: { $0.id == newWork.id }) {
            works[index] = newWork
        } else {
            works.insert(newWork, at: 0)
        }
        persist()
    }

    func delete(at offsets: IndexSet) {
        works.remove(atOffsets: offsets)
        persist()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            works = []
            return
        }

        works = (try? JSONDecoder().decode([ChatWork].self, from: data)) ?? []
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(works) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
