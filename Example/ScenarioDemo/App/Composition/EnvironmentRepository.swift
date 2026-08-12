import Foundation

/// Demo implementation representing a real repository configured for a selected environment.
/// Replace the simulated values with your APIClient calls in a production project.
struct EnvironmentRepository: AppRepository {
  let environment: AppEnvironment

  func signIn(email: String, password: String) async throws -> AppUser {
    try await Task.sleep(nanoseconds: 550_000_000)

    guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
      !password.isEmpty
    else {
      throw AppDemoError.invalidCredentials
    }

    return AppUser(
      name: "Demo User",
      email: email
    )
  }

  func loadDashboard() async throws -> [DashboardItem] {
    try await Task.sleep(nanoseconds: 700_000_000)

    return [
      DashboardItem(
        title: "Connected to \(environment.shortTitle)",
        subtitle: environment.baseURLDescription
      ),
      DashboardItem(
        title: "Real application composition",
        subtitle: "Replace EnvironmentRepository with your API-backed repository."
      ),
      DashboardItem(
        title: "Shared presentation layer",
        subtitle: "These are the same screens used by Mocked Application and Screen Catalog."
      ),
    ]
  }

  func loadProfile() async throws -> UserProfile {
    try await Task.sleep(nanoseconds: 400_000_000)

    return UserProfile(
      name: "Demo User",
      email: "demo@\(environment.rawValue).example",
      plan: environment == .live ? "Production account" : "Internal tester",
      environmentDescription: "\(environment.title) • \(environment.baseURLDescription)"
    )
  }
}
