import SwiftUI

protocol RecentSearchItemViewActions {
    func deleteRecent(item: SearchItem)
    func saveRecent(item: SearchItem)
}

struct RecentSearchItemView: View {
    var item: SearchItem
    var actions: RecentSearchItemViewActions?
    let namespace: Namespace.ID

    @ViewBuilder
    var body: some View {
        NavigationLink {
            Text(item.title)
        } label: {
            SearchItemView(item: item, namespace: namespace)
        }
        .overlay(alignment: .topTrailing, content: { menuIcon })
        .disabled(item.state != .searchable)
    }

    var menuIcon: some View {
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
                withAnimation {
                    actions?.deleteRecent(item: item)
                }
            } label: {
                Label("Delete", systemImage: "minus.circle")
            }
            Button {
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
        RecentSearchItemView(item: .mock1, namespace: namespace)
    }
}
