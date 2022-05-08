import SwiftUI

extension View {
    @ViewBuilder func card(withShadow: Bool = true) -> some View {
        background(Color.backgroundSurfacePrimary)
            .foregroundColor(Color.onSurfacePrimary)
            .cornerRadius(.cornerRadiusS)
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: .cornerRadiusS))
            .if(withShadow, transform: { $0.cardShadow() })
    }
}
