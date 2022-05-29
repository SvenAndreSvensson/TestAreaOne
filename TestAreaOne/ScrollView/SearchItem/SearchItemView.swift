import SwiftUI

struct SearchItemView: View {
    var item: SearchItem
    var width: CGFloat? = 160
    let namespace: Namespace.ID

    @State private var animationAmount: CGFloat = 1

    var body: some View {
        VStack(alignment: .leading, spacing: .spacingS) {
            title
            description
            image
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .frame(width: width)
        .card()
        .id(item.id)
        .matchedGeometryEffect(id: "\(item.id)", in: namespace)
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
                        value: animationAmount
                    )
                    .onAppear {
                        animationAmount = 1.2
                    }

            default:
                ProgressView()
            }
        }
    }
}

struct SearchItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SearchItemView(item: .mock4, namespace: namespace)
    }
}
