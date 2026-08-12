import SwiftUI

struct ProfileScreen: View {
  let modeTitle: String
  let state: ProfileScreenState
  let onClose: () -> Void

  var body: some View {
    NavigationStack {
      Group {
        switch state {
        case .loading:
          ProgressView("Loading profile…")

        case .loaded(let profile):
          List {
            Section {
              HStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                  .font(.system(size: 52))
                  .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 4) {
                  Text(profile.name)
                    .font(.title3.bold())
                  Text(profile.email)
                    .foregroundStyle(.secondary)
                }
              }
              .padding(.vertical, 8)
            }

            Section("Account") {
              LabeledContent("Plan", value: profile.plan)
              LabeledContent("Mode", value: modeTitle)
            }

            Section("Composition") {
              Text(profile.environmentDescription)
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
          }

        case .error(let message):
          DemoMessageCard(
            systemImage: "person.crop.circle.badge.exclamationmark",
            title: "Profile unavailable",
            message: message
          )
          .padding(24)
        }
      }
      .navigationTitle("Profile")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Close", action: onClose)
        }
      }
    }
  }
}
