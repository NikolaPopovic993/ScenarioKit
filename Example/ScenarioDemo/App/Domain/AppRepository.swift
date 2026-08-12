import Foundation

protocol AppRepository: Sendable {
  func signIn(email: String, password: String) async throws -> AppUser
  func loadDashboard() async throws -> [DashboardItem]
  func loadProfile() async throws -> UserProfile
}
