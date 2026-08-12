import Foundation

@MainActor
final class ApplicationViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published private(set) var isAuthenticated = false
  @Published private(set) var loginState: LoginScreenState = .idle
  @Published private(set) var homeState: HomeScreenState = .loading
  @Published private(set) var profileState: ProfileScreenState = .loading
  @Published var isProfilePresented = false

  let modeTitle: String

  private let repository: any AppRepository
  private var authenticationTask: Task<Void, Never>?
  private var dashboardTask: Task<Void, Never>?
  private var profileTask: Task<Void, Never>?

  init(container: AppContainer) {
    modeTitle = container.displayMode
    repository = container.repository
  }

  func signIn() {
    authenticationTask?.cancel()
    loginState = .loading
    let email = email
    let password = password

    authenticationTask = Task { [weak self, repository] in
      do {
        _ = try await repository.signIn(email: email, password: password)
        try Task.checkCancellation()

        guard let self else { return }
        loginState = .idle
        isAuthenticated = true
        loadDashboard()
      } catch is CancellationError {
        return
      } catch {
        guard let self else { return }
        loginState = .error(error.localizedDescription)
      }
    }
  }

  private func loadDashboard() {
    dashboardTask?.cancel()
    homeState = .loading

    dashboardTask = Task { [weak self, repository] in
      do {
        let items = try await repository.loadDashboard()
        try Task.checkCancellation()

        guard let self else { return }
        homeState = items.isEmpty ? .empty : .loaded(items)
      } catch is CancellationError {
        return
      } catch {
        guard let self else { return }
        homeState = .error(error.localizedDescription)
      }
    }
  }

  func reloadDashboard() {
    loadDashboard()
  }

  func openProfile() {
    profileState = .loading
    isProfilePresented = true

    profileTask?.cancel()
    profileTask = Task { [weak self, repository] in
      do {
        let profile = try await repository.loadProfile()
        try Task.checkCancellation()

        guard let self else { return }
        profileState = .loaded(profile)
      } catch is CancellationError {
        return
      } catch {
        guard let self else { return }
        profileState = .error(error.localizedDescription)
      }
    }
  }

  func signOut() {
    authenticationTask?.cancel()
    dashboardTask?.cancel()
    profileTask?.cancel()
    email = ""
    password = ""
    loginState = .idle
    homeState = .loading
    profileState = .loading
    isProfilePresented = false
    isAuthenticated = false
  }
}
