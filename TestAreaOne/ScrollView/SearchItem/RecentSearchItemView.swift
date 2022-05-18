import SwiftUI

protocol RecentSearchItemViewActions {
    func deleteRecent(item: SearchItem)
    func saveRecent(item: SearchItem)
}

struct RecentSearchItemView: View {
    @Binding var item: SearchItem
    var actions: RecentSearchItemViewActions?
    let namespace: Namespace.ID

    @ViewBuilder
    var body: some View {
//        Group {
        switch item.state {
        case .searchable:
            NavigationLink {
                Text(item.title)
            } label: {
                SearchItemView(item: $item, namespace: namespace)
            }
            .overlay(alignment: .topTrailing, content: { overlay })
            .transition(.scale.combined(with: .opacity))
            .contextMenu { menuItems }

        default:
            SearchItemView(item: $item, namespace: namespace)
                .transition(.scale.combined(with: .opacity))
        }
//        }
//        .matchedGeometryEffect(id: "\(item.id)", in: namespace)
    }

    var overlay: some View {
        Menu { menuItems } label: {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "target")
                    .resizable()
                    .border(.red)
                    .opacity(0.005)
                Image(systemName: "ellipsis")
                    .padding(.vertical, .spacingXS)
                    .padding(.horizontal, .spacingL)
                    .foregroundColor(.onSurfacePrimary)
            }
            .frame(width: 50, height: 50, alignment: .center)
        }
    }

    var menuItems: some View {
        Group {
            Button {
                item.state = .deleting
                withAnimation {
                    actions?.deleteRecent(item: item)
                }
            } label: {
                Label("Delete", systemImage: "minus.circle")
            }
            Button {
                item.state = .saving
                withAnimation {
                    actions?.saveRecent(item: item)
                }
            } label: {
                Label("Save", systemImage: "heart")
            }
        }
    }
}

struct RecentSearchItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        RecentSearchItemView(item: .constant(.mock1), namespace: namespace)
    }
}
