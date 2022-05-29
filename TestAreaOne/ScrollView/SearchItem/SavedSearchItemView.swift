import SwiftUI

protocol SavedSearchItemViewActions {
    func deleteSaved(item: SearchItem)
    func renameSaved(item: SearchItem, title: String)
}

struct SavedSearchItemView: View {
    var item: SearchItem
    var actions: SavedSearchItemViewActions?
    let namespace: Namespace.ID

    @State private var showingPopover = false
    @State private var name: String = ""

    var body: some View {

        NavigationLink {
            Text(item.title)
        } label: {
            SearchItemView(item: item, namespace: namespace)
        }
        .overlay(iconMenu, alignment: .topTrailing)
        .sheet(isPresented: $showingPopover) { popOver }
        .disabled(item.state != .searchable)
    }

    var menuItems: some View {
        Group {
            Button { actions?.deleteSaved(item: item) } label: {
                Label("Delete", systemImage: "minus.circle")
            }
            Button { name = item.title; showingPopover = true } label: {
                Label("Rename", systemImage: "pencil")
            }
        }
    }

    var iconMenu: some View {
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

    var popOver: some View {
        NavigationView {
            Form {
                Section {
                    TextField(text: $name) {
                        Text("Name")
                    }
                }
                header: { Text("Name the ta ta") }
                footer: { Text("Name the ta ta").font(.footnote) }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: { showingPopover = false })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: {
                        showingPopover = false; actions?.renameSaved(item: item, title: name)
                    })
                }
            }
        }
    }
}

struct SavedSearchItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SavedSearchItemView(item: .mock4, namespace: namespace)
    }
}
