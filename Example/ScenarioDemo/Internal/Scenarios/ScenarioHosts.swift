import SwiftUI

struct LoginScenarioHost: View {
  @State private var email = ""
  @State private var password = ""
  let state: LoginScreenState

  var body: some View {
    LoginScreen(
      email: $email,
      password: $password,
      modeTitle: "Scenario",
      state: state,
      onSignIn: {}
    )
  }
}

struct HomeScenarioHost: View {
  let state: HomeScreenState

  var body: some View {
    HomeScreen(
      modeTitle: "Scenario",
      state: state,
      onReload: {},
      onOpenProfile: {},
      onSignOut: {}
    )
  }
}

struct ProfileScenarioHost: View {
  let profile: UserProfile

  var body: some View {
    ProfileScreen(
      modeTitle: "Scenario",
      state: .loaded(profile),
      onClose: {}
    )
  }
}
