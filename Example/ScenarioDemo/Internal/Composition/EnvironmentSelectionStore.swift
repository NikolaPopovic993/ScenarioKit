import ScenarioKit

extension UserDefaultsScenarioEnvironmentSelectionStore {
  static var demo: Self {
    Self(namespace: "com.example.ScenarioDemoInternal")
  }
}
