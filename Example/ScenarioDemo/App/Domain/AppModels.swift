import Foundation

struct AppUser: Equatable, Sendable {
  let name: String
  let email: String
}

struct DashboardItem: Identifiable, Equatable, Sendable {
  let id: UUID
  let title: String
  let subtitle: String

  init(id: UUID = UUID(), title: String, subtitle: String) {
    self.id = id
    self.title = title
    self.subtitle = subtitle
  }
}

struct UserProfile: Equatable, Sendable {
  let name: String
  let email: String
  let plan: String
  let environmentDescription: String
}

enum AppDemoError: LocalizedError, Equatable {
  case invalidCredentials
  case unavailable(String)

  var errorDescription: String? {
    switch self {
    case .invalidCredentials:
      "Enter any non-empty email and password."
    case .unavailable(let message):
      message
    }
  }
}
