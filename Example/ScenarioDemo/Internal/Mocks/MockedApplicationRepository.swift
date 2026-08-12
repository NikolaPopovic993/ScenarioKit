import Foundation

/// Fully mocked repository used only by the internal target.
struct MockedApplicationRepository: AppRepository {
  func signIn(email: String, password: String) async throws -> AppUser {
    try await Task.sleep(nanoseconds: 250_000_000)
    return AppUser(name: "Mocked User", email: "mocked@example.com")
  }

  func loadDashboard() async throws -> [DashboardItem] {
    try await Task.sleep(nanoseconds: 350_000_000)
    return [
      DashboardItem(
        title: "Fully mocked application",
        subtitle: "No API, database, token, or production dependency is used."
      ),
      DashboardItem(
        title: "Production presentation layer",
        subtitle: "The same ApplicationRootView and screens are reused."
      ),
      DashboardItem(
        title: "Deterministic data",
        subtitle: "Useful for demos, QA, screenshots, and UI development."
      ),
    ]
  }

  func loadProfile() async throws -> UserProfile {
    try await Task.sleep(nanoseconds: 200_000_000)
    return UserProfile(
      name: "Mocked User",
      email: "mocked@example.com",
      plan: "Premium Mock",
      environmentDescription: "MockedApplicationRepository • completely isolated"
    )
  }
}

extension AppContainerFactory {
  static func makeMockedApplication() -> AppContainer {
    AppContainer(
      displayMode: "Mocked",
      repository: MockedApplicationRepository()
    )
  }
}
