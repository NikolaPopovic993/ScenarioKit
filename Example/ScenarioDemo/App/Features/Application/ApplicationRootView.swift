import SwiftUI

struct ApplicationRootView: View {
  @StateObject private var viewModel: ApplicationViewModel

  init(container: AppContainer) {
    _viewModel = StateObject(
      wrappedValue: ApplicationViewModel(container: container)
    )
  }

  var body: some View {
    NavigationStack {
      if viewModel.isAuthenticated {
        HomeScreen(
          modeTitle: viewModel.modeTitle,
          state: viewModel.homeState,
          onReload: viewModel.reloadDashboard,
          onOpenProfile: viewModel.openProfile,
          onSignOut: viewModel.signOut
        )
      } else {
        LoginScreen(
          email: $viewModel.email,
          password: $viewModel.password,
          modeTitle: viewModel.modeTitle,
          state: viewModel.loginState,
          onSignIn: viewModel.signIn
        )
      }
    }
    .sheet(isPresented: $viewModel.isProfilePresented) {
      ProfileScreen(
        modeTitle: viewModel.modeTitle,
        state: viewModel.profileState,
        onClose: { viewModel.isProfilePresented = false }
      )
    }
  }
}
