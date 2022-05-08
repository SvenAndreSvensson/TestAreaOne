import Foundation
import SwiftUI

extension View {
    /// A  modifier to add shadow for card
    func cardShadow() -> some View {
        shadow(color: .black.opacity(0.11), radius: 6, x: 0, y: 1.2)
    }
}
