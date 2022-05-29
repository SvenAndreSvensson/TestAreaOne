struct SearchItem: Identifiable {
    let id: String
    var title: String
    var description: String = "description"
    var icon: SystemName = "magnifyingglass"

    var state: State = .searchable

    enum State {
        case searchable
        case deleting
        case saving
        case renaming
    }

    typealias SystemName = String
}

extension SearchItem {
    static var zero: Self {
        .init(id: "zero", title: "")
    }
}

extension SearchItem: Equatable {

    static func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
        lhs.id == rhs.id  && lhs.state == rhs.state
//         && lhs.title == rhs.title
//        lhs.description == rhs.description &&
//        lhs.state == rhs.state
    }
}

extension SearchItem {
    static var mock1: Self {
        .init(id: "1", title: "Storo", description: "Storo, James Dean", icon: "magnifyingglass")
    }

    static var mock2: Self {
        .init(id: "2", title: "Abba", description: "ABBA, Fredriksson", icon: "magnifyingglass")
    }

    static var mock3: Self {
        .init(id: "3", title: "Bryn", description: "Bryn, Helga", icon: "magnifyingglass")
    }

    static var mock4: Self {
        .init(id: "4", title: "Asker", description: "Asker, Sweet", icon: "magnifyingglass")
    }

    static var mock5: Self {
        .init(id: "5", title: "Kolsås", description: "Kolsås, Per", icon: "magnifyingglass")
    }

    static var mock6: Self {
        .init(id: "6", title: "Gjettum", description: "Gjettum, Arne", icon: "magnifyingglass")
    }
}
