import Foundation

public struct ScenarioMockedApplicationOption: Hashable, Sendable {
  public let title: String
  public let subtitle: String
  public let systemImage: String

  public init(
    title: String = "Mocked Application",
    subtitle: String = "Start the entire application with mocked dependencies",
    systemImage: String = "sparkles.rectangle.stack"
  ) {
    self.title = title
    self.subtitle = subtitle
    self.systemImage = systemImage
  }
}

/// Text and options used by the reusable launcher screen.
public struct ScenarioLauncherConfiguration: Sendable {
  public let title: String
  public let environments: [ScenarioEnvironment]
  public let mockedApplication: ScenarioMockedApplicationOption?
  public let continueSectionTitle: String
  public let applicationSectionTitle: String
  public let scenarioSectionPrefix: String

  public init(
    title: String = "Internal Launcher",
    environments: [ScenarioEnvironment],
    mockedApplication: ScenarioMockedApplicationOption? = ScenarioMockedApplicationOption(),
    continueSectionTitle: String = "Continue",
    applicationSectionTitle: String = "Start Application",
    scenarioSectionPrefix: String = "Screen Catalog"
  ) {
    self.title = title
    self.environments = environments
    let duplicateEnvironmentIDs = Dictionary(grouping: environments, by: \.id)
      .filter { $0.value.count > 1 }
      .map(\.key)
      .sorted()

    precondition(
      duplicateEnvironmentIDs.isEmpty,
      "Environment IDs must be unique. Duplicates: \(duplicateEnvironmentIDs.joined(separator: ", "))"
    )

    self.mockedApplication = mockedApplication
    self.continueSectionTitle = continueSectionTitle
    self.applicationSectionTitle = applicationSectionTitle
    self.scenarioSectionPrefix = scenarioSectionPrefix
  }

  public func environment(id: String) -> ScenarioEnvironment? {
    environments.first { $0.id == id }
  }
}
