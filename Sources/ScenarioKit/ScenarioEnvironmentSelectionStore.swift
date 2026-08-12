import Foundation

@MainActor
public protocol ScenarioEnvironmentSelectionStoring {
  func save(environmentID: String)
  func loadEnvironmentID() -> String?
}

/// Default persistence used to remember the last environment selected by the developer.
@MainActor
public struct UserDefaultsScenarioEnvironmentSelectionStore: ScenarioEnvironmentSelectionStoring {
  private let defaults: UserDefaults
  private let key: String

  public init(
    namespace: String,
    defaults: UserDefaults = .standard
  ) {
    self.defaults = defaults
    self.key = "\(namespace).scenario-kit.last-environment"
  }

  public func save(environmentID: String) {
    defaults.set(environmentID, forKey: key)
  }

  public func loadEnvironmentID() -> String? {
    defaults.string(forKey: key)
  }
}
