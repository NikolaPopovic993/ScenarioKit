import SwiftUI

/// A self-contained screen scenario supplied by the host application.
///
/// Keep the metadata, mocked dependencies and production view for one scenario
/// together in a dedicated file, then add the scenario to a ``ScenarioCatalog``.
@MainActor
public protocol Scenario {
  associatedtype Content: View

  var metadata: ScenarioMetadata { get }

  @ViewBuilder
  func makeBody() -> Content
}

/// Internal type erasure used only at the catalog composition boundary.
struct ScenarioDefinition: Identifiable {
  let metadata: ScenarioMetadata
  private let viewFactory: @MainActor () -> AnyView

  var id: String {
    metadata.id
  }

  @MainActor
  init<Content: View>(
    metadata: ScenarioMetadata,
    @ViewBuilder makeView: @escaping @MainActor () -> Content
  ) {
    self.metadata = metadata
    self.viewFactory = {
      AnyView(makeView())
    }
  }

  @MainActor
  init<S: Scenario>(_ scenario: S) {
    self.init(metadata: scenario.metadata) {
      scenario.makeBody()
    }
  }

  @MainActor
  func makeView() -> AnyView {
    viewFactory()
  }
}
