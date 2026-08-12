import SwiftUI

struct LoginScreen: View {
  @Binding var email: String
  @Binding var password: String

  let modeTitle: String
  let state: LoginScreenState
  let onSignIn: () -> Void

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        HStack {
          DemoModeBadge(title: modeTitle)
          Spacer()
        }

        VStack(alignment: .leading, spacing: 8) {
          Text("Welcome back")
            .font(.largeTitle.bold())

          Text("This screen is shared by the real app, Mocked Application, and isolated scenarios.")
            .foregroundStyle(.secondary)
        }

        VStack(spacing: 14) {
          TextField("Email", text: $email)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14))

          SecureField("Password", text: $password)
            .textContentType(.password)
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14))
        }

        if case .error(let message) = state {
          Label(message, systemImage: "exclamationmark.triangle.fill")
            .font(.subheadline)
            .foregroundStyle(.red)
        }

        Button(action: onSignIn) {
          HStack {
            Spacer()

            if state == .loading {
              ProgressView()
                .tint(.white)
            } else {
              Text("Sign In")
                .fontWeight(.semibold)
            }

            Spacer()
          }
          .frame(height: 50)
        }
        .buttonStyle(.borderedProminent)
        .disabled(state == .loading)

        Text("Demo tip: in real-environment mode, enter any non-empty values.")
          .font(.footnote)
          .foregroundStyle(.secondary)
      }
      .padding(24)
    }
    .background(
      LinearGradient(
        colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
        startPoint: .top,
        endPoint: .bottom
      )
    )
    .navigationTitle("Login")
    .navigationBarTitleDisplayMode(.inline)
  }
}
