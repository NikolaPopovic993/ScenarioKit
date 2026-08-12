import ScenarioKit

@MainActor
enum ScenarioCatalogFactory {
  static func makeCatalog() -> ScenarioCatalog {
    ScenarioCatalog {
      LoginEmptyScenario()
      LoginValidationErrorScenario()
      LoginLoadingScenario()
      HomeLoadedScenario()
      HomeEmptyScenario()
      HomeErrorScenario()
      ProfileFreeScenario()
      ProfilePremiumScenario()
      AuthenticationFlowScenario()
    }
  }
}
