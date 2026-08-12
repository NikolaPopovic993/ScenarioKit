import SwiftUI

/// Switches the entire internal target root between launcher, real app, mocked app and one scenario.
@MainActor
public struct ScenarioKitRootView: View {
  @ObservedObject private var session: ScenarioSession

  private let configuration: ScenarioLauncherConfiguration
  private let catalog: ScenarioCatalog
  private let applicationFactory: @MainActor (String) -> AnyView
  private let mockedApplicationFactory: @MainActor () -> AnyView

  public init<ApplicationContent: View, MockedApplicationContent: View>(
    session: ScenarioSession,
    configuration: ScenarioLauncherConfiguration,
    catalog: ScenarioCatalog,
    @ViewBuilder makeApplication: @escaping @MainActor (String) -> ApplicationContent,
    @ViewBuilder makeMockedApplication: @escaping @MainActor () -> MockedApplicationContent
  ) {
    self.session = session
    self.configuration = configuration
    self.catalog = catalog
    self.applicationFactory = { AnyView(makeApplication($0)) }
    self.mockedApplicationFactory = { AnyView(makeMockedApplication()) }
  }

  public var body: some View {
    Group {
      switch session.mode {
      case .launcher:
        ScenarioLauncherView(
          session: session,
          configuration: configuration,
          catalog: catalog
        )

      case .application(let environmentID):
        if configuration.environment(id: environmentID) != nil {
          applicationFactory(environmentID)
        } else {
          ScenarioUnavailableView(
            title: "Environment not found",
            identifier: environmentID,
            onShowLauncher: session.showLauncher
          )
        }

      case .mockedApplication:
        mockedApplicationFactory()

      case .scenario(let id):
        if let view = catalog.makeView(for: id) {
          view
        } else {
          ScenarioUnavailableView(
            title: "Scenario not found",
            identifier: id,
            onShowLauncher: session.showLauncher
          )
        }
      }
    }
    .animation(.easeInOut(duration: 0.18), value: session.mode)
  }
}

private struct ScenarioUnavailableView: View {
  let title: String
  let identifier: String
  let onShowLauncher: () -> Void

  var body: some View {
    VStack(spacing: 12) {
      Image(systemName: "exclamationmark.triangle")
        .font(.largeTitle)

      Text(title)
        .font(.headline)

      Text(identifier)
        .font(.caption.monospaced())
        .foregroundColor(.secondary)

      Button("Return to Launcher", action: onShowLauncher)
        .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
