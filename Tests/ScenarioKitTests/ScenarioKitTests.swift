import SwiftUI
import XCTest

@testable import ScenarioKit

@MainActor
final class ScenarioKitTests: XCTestCase {
  private final class SelectionStore: ScenarioEnvironmentSelectionStoring {
    var environmentID: String?
    private(set) var savedEnvironmentIDs: [String] = []

    init(environmentID: String? = nil) {
      self.environmentID = environmentID
    }

    func save(environmentID: String) {
      self.environmentID = environmentID
      savedEnvironmentIDs.append(environmentID)
    }

    func loadEnvironmentID() -> String? {
      environmentID
    }
  }

  private struct TestScenario: Scenario {
    let metadata: ScenarioMetadata
    let content: String

    init(
      id: String,
      title: String,
      category: String,
      content: String = "Content"
    ) {
      metadata = ScenarioMetadata(
        id: id,
        title: title,
        category: category
      )
      self.content = content
    }

    func makeBody() -> some View {
      Text(content)
    }
  }

  func test_catalog_groups_categories_and_sorts_scenarios() {
    let sut = ScenarioCatalog {
      TestScenario(id: "home.second", title: "Second", category: "Home")
      TestScenario(id: "auth.first", title: "First", category: "Authentication")
      TestScenario(id: "home.first", title: "First", category: "Home")
    }

    XCTAssertEqual(sut.categories, ["Authentication", "Home"])
    XCTAssertEqual(
      sut.scenarios(in: "Home").map(\.id),
      ["home.first", "home.second"]
    )
  }

  func test_catalog_builder_supports_conditionals_and_collections() {
    let includesOptionalScenario = true
    let repeatedScenarios = [
      TestScenario(id: "profile.free", title: "Free", category: "Profile"),
      TestScenario(id: "profile.premium", title: "Premium", category: "Profile"),
    ]

    let sut = ScenarioCatalog {
      TestScenario(id: "home.loaded", title: "Loaded", category: "Home")

      if includesOptionalScenario {
        TestScenario(id: "home.empty", title: "Empty", category: "Home")
      }

      for scenario in repeatedScenarios {
        scenario
      }
    }

    XCTAssertEqual(
      sut.scenarios.map(\.id),
      ["home.loaded", "home.empty", "profile.free", "profile.premium"]
    )
  }

  func test_catalog_returns_view_only_for_registered_scenario() {
    let sut = ScenarioCatalog {
      TestScenario(id: "home.loaded", title: "Loaded", category: "Home")
    }

    XCTAssertNotNil(sut.makeView(for: "home.loaded"))
    XCTAssertNil(sut.makeView(for: "home.missing"))
  }

  func test_session_starts_in_launcher_by_default() {
    let sut = ScenarioSession(selectionStore: SelectionStore())

    XCTAssertEqual(sut.mode, .launcher)
    XCTAssertNil(sut.lastEnvironmentID)
    XCTAssertNil(sut.selectedEnvironmentID)
  }

  func test_session_start_saves_environment_and_updates_mode() {
    let store = SelectionStore()
    let sut = ScenarioSession(selectionStore: store)

    sut.start(environmentID: "stage")

    XCTAssertEqual(store.savedEnvironmentIDs, ["stage"])
    XCTAssertEqual(sut.lastEnvironmentID, "stage")
    XCTAssertEqual(sut.selectedEnvironmentID, "stage")
    XCTAssertEqual(sut.mode, .application(environmentID: "stage"))
  }

  func test_session_switches_between_internal_modes() {
    let sut = ScenarioSession(selectionStore: SelectionStore())

    sut.startMockedApplication()
    XCTAssertEqual(sut.mode, .mockedApplication)

    sut.openScenario(id: "flow.checkout")
    XCTAssertEqual(sut.mode, .scenario(id: "flow.checkout"))

    sut.showLauncher()
    XCTAssertEqual(sut.mode, .launcher)
  }

  func test_session_restores_last_environment_when_enabled() {
    let sut = ScenarioSession(
      restoreLastEnvironmentOnLaunch: true,
      selectionStore: SelectionStore(environmentID: "stage")
    )

    XCTAssertEqual(sut.mode, .application(environmentID: "stage"))
    XCTAssertEqual(sut.lastEnvironmentID, "stage")
    XCTAssertEqual(sut.selectedEnvironmentID, "stage")
  }

  func test_user_defaults_store_persists_environment_id() throws {
    let suiteName = "ScenarioKitTests.\(UUID().uuidString)"
    let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
    defer { defaults.removePersistentDomain(forName: suiteName) }

    let sut = UserDefaultsScenarioEnvironmentSelectionStore(
      namespace: "tests",
      defaults: defaults
    )

    XCTAssertNil(sut.loadEnvironmentID())

    sut.save(environmentID: "stage")

    XCTAssertEqual(sut.loadEnvironmentID(), "stage")
  }

  func test_launcher_configuration_finds_environment_by_id() throws {
    let stage = ScenarioEnvironment(
      id: "stage",
      title: "Stage",
      subtitle: "Staging backend",
      systemImage: "testtube.2"
    )
    let sut = ScenarioLauncherConfiguration(environments: [stage])

    XCTAssertEqual(try XCTUnwrap(sut.environment(id: "stage")), stage)
    XCTAssertNil(sut.environment(id: "missing"))
  }
}
