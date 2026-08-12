import SwiftUI

/// Reusable pre-application launcher shown by an internal/debug app target.
@MainActor
public struct ScenarioLauncherView: View {
  @ObservedObject private var session: ScenarioSession

  private let configuration: ScenarioLauncherConfiguration
  private let catalog: ScenarioCatalog

  @State private var searchText = ""
  @State private var pendingEnvironment: ScenarioEnvironment?

  public init(
    session: ScenarioSession,
    configuration: ScenarioLauncherConfiguration,
    catalog: ScenarioCatalog
  ) {
    self.session = session
    self.configuration = configuration
    self.catalog = catalog
  }

  public var body: some View {
    NavigationView {
      List {
        continueSection
        applicationSection
        scenarioSections
      }
      .navigationTitle(configuration.title)
      .searchable(text: $searchText, prompt: "Search scenarios")
      .alert(item: $pendingEnvironment) { environment in
        Alert(
          title: Text(environment.confirmationTitle ?? "Start \(environment.title)?"),
          message: Text(
            environment.confirmationMessage ?? "This environment requires confirmation."),
          primaryButton: .destructive(Text("Start")) {
            session.start(environmentID: environment.id)
          },
          secondaryButton: .cancel()
        )
      }
    }
    .navigationViewStyle(.stack)
  }

  @ViewBuilder
  private var continueSection: some View {
    if let id = session.lastEnvironmentID,
      let environment = configuration.environment(id: id)
    {
      Section(configuration.continueSectionTitle) {
        Button {
          start(environment)
        } label: {
          ScenarioLauncherRow(
            title: "Continue with \(environment.title)",
            subtitle: "Last selected environment",
            systemImage: "play.circle.fill"
          )
        }
      }
    }
  }

  private var applicationSection: some View {
    Section(configuration.applicationSectionTitle) {
      ForEach(configuration.environments) { environment in
        Button {
          start(environment)
        } label: {
          ScenarioLauncherRow(
            title: environment.title,
            subtitle: environment.subtitle,
            systemImage: environment.systemImage
          )
        }
      }

      if let mockedApplication = configuration.mockedApplication {
        Button {
          session.startMockedApplication()
        } label: {
          ScenarioLauncherRow(
            title: mockedApplication.title,
            subtitle: mockedApplication.subtitle,
            systemImage: mockedApplication.systemImage
          )
        }
      }
    }
  }

  @ViewBuilder
  private var scenarioSections: some View {
    ForEach(filteredCategories, id: \.self) { category in
      Section("\(configuration.scenarioSectionPrefix) • \(category)") {
        ForEach(filteredScenarios(in: category)) { scenario in
          Button {
            session.openScenario(id: scenario.id)
          } label: {
            ScenarioLauncherRow(
              title: scenario.metadata.title,
              subtitle: scenario.metadata.subtitle,
              systemImage: scenario.metadata.systemImage
            )
          }
        }
      }
    }
  }

  private var filteredCategories: [String] {
    catalog.categories.filter { !filteredScenarios(in: $0).isEmpty }
  }

  private func filteredScenarios(in category: String) -> [ScenarioDefinition] {
    let scenarios = catalog.scenarios(in: category)
    guard !searchText.isEmpty else {
      return scenarios
    }

    return scenarios.filter {
      $0.metadata.title.localizedCaseInsensitiveContains(searchText)
        || ($0.metadata.subtitle?.localizedCaseInsensitiveContains(searchText) ?? false)
        || $0.metadata.category.localizedCaseInsensitiveContains(searchText)
    }
  }

  private func start(_ environment: ScenarioEnvironment) {
    if environment.requiresConfirmation {
      pendingEnvironment = environment
    } else {
      session.start(environmentID: environment.id)
    }
  }
}

private struct ScenarioLauncherRow: View {
  let title: String
  let subtitle: String?
  let systemImage: String

  var body: some View {
    Label {
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.headline)
          .foregroundColor(.primary)

        if let subtitle, !subtitle.isEmpty {
          Text(subtitle)
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      .padding(.vertical, 4)
    } icon: {
      Image(systemName: systemImage)
        .frame(width: 28)
    }
  }
}
