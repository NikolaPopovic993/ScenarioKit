import SwiftUI

struct HomeScreen: View {
  let modeTitle: String
  let state: HomeScreenState
  let onReload: () -> Void
  let onOpenProfile: () -> Void
  let onSignOut: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      header

      Group {
        switch state {
        case .loading:
          VStack(spacing: 14) {
            ProgressView()
            Text("Loading dashboard…")
              .foregroundStyle(.secondary)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let items):
          List(items) { item in
            VStack(alignment: .leading, spacing: 6) {
              Text(item.title)
                .font(.headline)
              Text(item.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding(.vertical, 6)
          }
          .listStyle(.plain)

        case .empty:
          DemoMessageCard(
            systemImage: "tray",
            title: "Nothing here yet",
            message: "This is the isolated empty-state scenario."
          )
          .padding(24)
          .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .error(let message):
          VStack(spacing: 18) {
            DemoMessageCard(
              systemImage: "wifi.exclamationmark",
              title: "Could not load dashboard",
              message: message
            )

            Button("Try Again", action: onReload)
              .buttonStyle(.borderedProminent)
          }
          .padding(24)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }
    }
    .navigationTitle("Dashboard")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var header: some View {
    HStack(spacing: 12) {
      DemoModeBadge(title: modeTitle)
      Spacer()

      Button(action: onOpenProfile) {
        Image(systemName: "person.crop.circle")
          .font(.title2)
      }
      .accessibilityLabel("Open profile")

      Menu {
        Button("Reload", systemImage: "arrow.clockwise", action: onReload)
        Button(
          "Sign Out", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive,
          action: onSignOut)
      } label: {
        Image(systemName: "ellipsis.circle")
          .font(.title2)
      }
      .accessibilityLabel("More options")
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
    .background(.bar)
  }
}
