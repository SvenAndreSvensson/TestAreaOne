import SwiftUI

protocol SavedSearchItemViewActions {
    func deleteSaved(item: SearchItem)
    func renameSaved(item:SearchItem, title: String)
}

struct SavedSearchItemView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var item: SearchItem
    var actions: SavedSearchItemViewActions?
    let namespace: Namespace.ID

    @State private var showingPopover = false
    @State private var name: String = ""

    @State private var animationAmount: CGFloat = 1
    @FocusState private var isFocused: Bool

    var body: some View {
        Group {
            switch item.state {
            case .searchable:
                NavigationLink {
                    Text(item.title)
                } label: {
                    searchItem
                        .contextMenu { menuItems }
                }

            default:
                searchItem
            }
        }
        .matchedGeometryEffect(id: "\(item.id)", in: namespace)
        .transition(.scale.combined(with: .opacity))
        .popover(isPresented: $showingPopover) { popOver }
        .overlay(alignment: .topTrailing, content: {
            Menu {  menuItems } label: {
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
        })
    }

    var searchItem: some View {
        VStack(alignment: .leading, spacing: .spacingS) {
            title
            description
            image
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .frame(width: 160)
        .card()
    }

    var title: some View {
        Text(item.title)
            .font(.body)
    }

    var description: some View {
        Text(item.description)
            .font(.caption)
    }

    var image: some View {
        HStack(spacing: .spacingS) {
            Spacer()
            switch item.state {
            case .searchable:
                Image(systemName: item.icon)

            case .saving:
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.red)
                    .scaleEffect(animationAmount)
                    .animation(
                        .linear(duration: 0.1)
                        .delay(0.2)
                        .repeatForever(autoreverses: true),
                        value: animationAmount)
                    .onAppear {
                        animationAmount = 1.2
                    }

            default:
                ProgressView()
            }
        }
    }

    var menuItems: some View {
        Group {
            Button { actions?.deleteSaved(item: item)  } label: {
                Label("Delete", systemImage: "minus.circle")
            }
            Button { name = item.title; showingPopover = true  } label: {
                Label("Rename", systemImage: "pencil")
            }
        }
    }

    var popOver: some View {
        NavigationView {
            Form {
                Section {
                    TextField(text: $name) {
                        Text("Name")
                    }
                    .focused($isFocused)
                    .onAppear {
                        Task {
                            do {
                                try await Task.sleep(nanoseconds: 2_000_000_000)
                                isFocused = true
                            } catch {

                            }
                        }

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
        SavedSearchItemView(item: .constant(.mock4), namespace: namespace)
    }
}
