import SwiftUI

struct SuggestedSearchItemView: View {
    @Binding var item: SearchItem
    let namespace: Namespace.ID

    var body: some View {
        NavigationLink {
            Text(item.title)
        } label: {
            SearchItemView(item: $item, width: nil, namespace: namespace)
        }
    }
}

struct SuggestedSearchItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SuggestedSearchItemView(item: .constant(.mock6), namespace: namespace)
    }
}
