import Foundation

class SearchItemsViewModel: ObservableObject {
    @Published var recentItems: [SearchItem]
    @Published var savedItems: [SearchItem]
    @Published var suggestedItem: SearchItem

    init(recentItems: [SearchItem] = [], savedItems: [SearchItem] = [], suggestedItem: SearchItem? = nil) {
        self.recentItems = recentItems
        self.savedItems = savedItems
        self.suggestedItem = suggestedItem ?? .zero
    }
}

extension SearchItemsViewModel {
    // Recent
    func removeRecent(_ item: SearchItem) -> SearchItem? {
        guard let index = recentItems.firstIndex(where: { $0.id == item.id }) else { return nil }
        return recentItems.remove(at: index)
    }

    func setRecentState(for item: SearchItem, to state: SearchItem.State) {
        guard let index = recentItems.firstIndex(where: { $0.id == item.id }) else { return }
        recentItems[index].state = state
    }

    // Saved
    func setSavedState(for item: SearchItem, to state: SearchItem.State) {
        guard let index = savedItems.firstIndex(where: { $0.id == item.id }) else { return }
        savedItems[index].state = state
    }

    func removeSaved(_ item: SearchItem) -> SearchItem? {
        guard let index = savedItems.firstIndex(where: { $0.id == item.id }) else { return nil }
        return savedItems.remove(at: index)
    }

    func renameSavedItem(_ item: SearchItem, with title: String) -> SearchItem? {
        guard let index = savedItems.firstIndex(where: { $0.id == item.id }) else { return nil }
        savedItems[index].title = title
        savedItems[index].state = .searchable
        return savedItems[index]
    }

    func insertSaved(_ item: SearchItem) {
        savedItems.insert(item, at: 0)
        // savedItems[0].state = .searchable
    }
}

extension SearchItemsViewModel: Equatable {
    static func == (lhs: SearchItemsViewModel, rhs: SearchItemsViewModel) -> Bool {
        lhs.recentItems == rhs.recentItems &&
            lhs.savedItems == rhs.savedItems
    }
}

extension SearchItemsViewModel: RecentSearchItemViewActions {
    func deleteRecent(item: SearchItem) {
        Task { @MainActor in
            do {
                // set item state
                setRecentState(for: item, to: .deleting)

                try await Task.sleep(nanoseconds: 2_000_000_000)

                removeRecent(item)

            } catch {
                setRecentState(for: item, to: .searchable)
            }
        }
    }

    func saveRecent(item: SearchItem) {
        Task { @MainActor in
            do {
                // set item state
                 setRecentState(for: item, to: .saving)

                try await Task.sleep(nanoseconds: 2_000_000_000)
                guard let item = removeRecent(item) else {
                    setRecentState(for: item, to: .searchable)
                    return
                }

                insertSaved(item)

                setSavedState(for: item, to: .searchable)

            } catch {
                setRecentState(for: item, to: .searchable)
                setSavedState(for: item, to: .searchable)
            }
        }
    }
}

extension SearchItemsViewModel: SavedSearchItemViewActions {
    func deleteSaved(item: SearchItem) {
        Task { @MainActor in
            do {
                // set item state
                setSavedState(for: item, to: .deleting)

                try await Task.sleep(nanoseconds: 2_000_000_000)

                removeSaved(item)

            } catch {
                setSavedState(for: item, to: .searchable)
            }
        }
    }

    func renameSaved(item: SearchItem, title: String) {
        Task { @MainActor in
            do {
                // set item state
                setSavedState(for: item, to: .renaming)

                try await Task.sleep(nanoseconds: 2_000_000_000)

                renameSavedItem(item, with: title)

                // setSavedState(for: item, to: .searchable)

            } catch {
                setSavedState(for: item, to: .searchable)
            }
        }
    }
}
