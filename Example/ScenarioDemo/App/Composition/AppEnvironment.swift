import Foundation

enum AppEnvironment: String, CaseIterable, Identifiable, Sendable {
  case development
  case stage
  case live

  var id: String { rawValue }

  var title: String {
    switch self {
    case .development: "Development"
    case .stage: "Stage"
    case .live: "Live"
    }
  }

  var shortTitle: String {
    switch self {
    case .development: "DEV"
    case .stage: "STAGE"
    case .live: "LIVE"
    }
  }

  var baseURLDescription: String {
    switch self {
    case .development: "https://api-dev.example.com"
    case .stage: "https://api-stage.example.com"
    case .live: "https://api.example.com"
    }
  }
}
