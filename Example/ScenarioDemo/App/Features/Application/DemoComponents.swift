import SwiftUI

struct DemoModeBadge: View {
  let title: String

  var body: some View {
    Text(title.uppercased())
      .font(.caption2.weight(.bold))
      .padding(.horizontal, 9)
      .padding(.vertical, 5)
      .background(.thinMaterial, in: Capsule())
      .accessibilityLabel("Mode: \(title)")
  }
}

struct DemoMessageCard: View {
  let systemImage: String
  let title: String
  let message: String

  var body: some View {
    VStack(spacing: 12) {
      Image(systemName: systemImage)
        .font(.system(size: 34))
        .foregroundStyle(.secondary)

      Text(title)
        .font(.headline)

      Text(message)
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
    .padding(24)
    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
  }
}
