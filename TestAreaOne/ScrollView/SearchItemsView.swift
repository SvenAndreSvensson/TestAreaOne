import SwiftUI

struct SearchItemsView: View {
    @ObservedObject var model: SearchItemsViewModel
    @Namespace var namespace

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ScrollView(.horizontal, showsIndicators: false) {
                GeometryReader{ proxy in
                    Canvas { context, size in
                        
                    }
                }


                HStack(alignment: .center, spacing: .spacingS) {
                    ForEach($model.recentItems) { $item in
                        RecentSearchItemView(item: $item, actions: model, namespace: namespace)
                    }
                }
                .buttonStyle(.plain)
                .padding()
            }
            .fixedSize(horizontal: false, vertical: true)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: .spacingS) {
                    ForEach($model.savedItems) { $item in
                        SavedSearchItemView(item: $item, actions: model, namespace: namespace)
                    }
                }
                .buttonStyle(.plain)
                .padding()
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .animation(.easeInOut, value: model.savedItems)
        .animation(.easeInOut, value: model.recentItems)

    }
}


