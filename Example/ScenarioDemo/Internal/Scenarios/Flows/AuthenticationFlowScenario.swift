import ScenarioKit
import SwiftUI

/// Demonstrates that a scenario can host an interactive feature flow, not only one screen state.
struct AuthenticationFlowScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "flow.authentication.happy-path",
    title: "Authentication → Dashboard",
    subtitle: "Interactive flow backed entirely by deterministic mocks",
    category: "Flows",
    systemImage: "arrow.triangle.branch"
  )

  func makeBody() -> some View {
    ApplicationRootView(
      container: AppContainerFactory.makeMockedApplication()
    )
  }
}
