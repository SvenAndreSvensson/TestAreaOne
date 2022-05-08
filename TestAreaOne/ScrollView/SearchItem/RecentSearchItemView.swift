import SwiftUI

protocol RecentSearchItemViewActions {
    func deleteRecent(item: SearchItem)
    func saveRecent(item:SearchItem)
}

struct RecentSearchItemView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var item: SearchItem
    var actions: RecentSearchItemViewActions?
    let namespace: Namespace.ID

    @State private var showingPopover = false
    @State private var name: String = "hei"

    @State private var animationAmount: CGFloat = 1

    @ViewBuilder
    var body: some View {
        Group {
        switch item.state {
        case .searchable:
            NavigationLink {
                Text(item.title)
            } label: {
                searchItem
                    .contextMenu { menu }
            }

        default:
            searchItem

        }
        }
        .matchedGeometryEffect(id: "\(item.id)", in: namespace)
        .transition(.scale.combined(with: .opacity))

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

    @ViewBuilder
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

    var menu: some View {
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
