import SwiftUI

@resultBuilder
@MainActor
public enum ScenarioCatalogBuilder {
  /// Result-builder plumbing. Application code never needs to construct this type directly.
  public struct Component {
    fileprivate let definitions: [ScenarioDefinition]

    fileprivate init(_ definitions: [ScenarioDefinition]) {
      self.definitions = definitions
    }
  }

  public static func buildExpression<S: Scenario>(_ scenario: S) -> Component {
    Component([ScenarioDefinition(scenario)])
  }

  public static func buildBlock(_ components: Component...) -> Component {
    Component(components.flatMap(\.definitions))
  }

  public static func buildOptional(_ component: Component?) -> Component {
    component ?? Component([])
  }

  public static func buildEither(first component: Component) -> Component {
    component
  }

  public static func buildEither(second component: Component) -> Component {
    component
  }

  public static func buildArray(_ components: [Component]) -> Component {
    Component(components.flatMap(\.definitions))
  }
}

/// Read-only registry of all screen scenarios supplied by the host application.
@MainActor
public struct ScenarioCatalog {
  let scenarios: [ScenarioDefinition]

  public init(@ScenarioCatalogBuilder scenarios: () -> ScenarioCatalogBuilder.Component) {
    let definitions = scenarios().definitions
    Self.validateUniqueIDs(in: definitions)
    self.scenarios = definitions
  }

  var categories: [String] {
    Array(Set(scenarios.map(\.metadata.category))).sorted()
  }

  func scenarios(in category: String) -> [ScenarioDefinition] {
    scenarios
      .filter { $0.metadata.category == category }
      .sorted { $0.metadata.title < $1.metadata.title }
  }

  func scenario(id: String) -> ScenarioDefinition? {
    scenarios.first { $0.id == id }
  }

  func makeView(for id: String) -> AnyView? {
    scenario(id: id)?.makeView()
  }

  private static func validateUniqueIDs(in definitions: [ScenarioDefinition]) {
    let duplicateIDs = Dictionary(grouping: definitions, by: \.id)
      .filter { $0.value.count > 1 }
      .map(\.key)
      .sorted()

    precondition(
      duplicateIDs.isEmpty,
      "Scenario IDs must be unique. Duplicates: \(duplicateIDs.joined(separator: ", "))"
    )
  }
}
