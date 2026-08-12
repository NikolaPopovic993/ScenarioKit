import ScenarioKit

@MainActor
enum InternalScenarioComposition {
  static let launcherConfiguration = ScenarioLauncherConfiguration(
    title: "Internal Launcher",
    environments: AppEnvironment.allCases.map(\.scenarioEnvironment),
    mockedApplication: ScenarioMockedApplicationOption(
      title: "Mocked Application",
      subtitle: "Start the entire app with mocked dependencies",
      systemImage: "sparkles.rectangle.stack"
    )
  )

  static let session = ScenarioSession(
    restoreLastEnvironmentOnLaunch: true,
    selectionStore: UserDefaultsScenarioEnvironmentSelectionStore.demo
  )

  static let catalog = ScenarioCatalogFactory.makeCatalog()
}

extension AppEnvironment {
  var scenarioEnvironment: ScenarioEnvironment {
    switch self {
    case .development:
      ScenarioEnvironment(
        id: rawValue,
        title: title,
        subtitle: baseURLDescription,
        systemImage: "hammer"
      )
    case .stage:
      ScenarioEnvironment(
        id: rawValue,
        title: title,
        subtitle: baseURLDescription,
        systemImage: "testtube.2"
      )
    case .live:
      ScenarioEnvironment(
        id: rawValue,
        title: title,
        subtitle: "\(baseURLDescription) — use carefully",
        systemImage: "exclamationmark.shield",
        requiresConfirmation: true,
        confirmationTitle: "Start Live environment?",
        confirmationMessage:
          "A real project should clearly protect access to its production backend."
      )
    }
  }
}
