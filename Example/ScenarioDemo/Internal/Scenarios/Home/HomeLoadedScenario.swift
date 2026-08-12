import ScenarioKit
import SwiftUI

struct HomeLoadedScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "home.dashboard.loaded",
    title: "Home – Loaded",
    subtitle: "Deterministic mocked dashboard data",
    category: "Home",
    systemImage: "rectangle.grid.1x2"
  )

  func makeBody() -> some View {
    HomeScenarioHost(
      state: .loaded([
        DashboardItem(
          title: "Mocked item",
          subtitle: "Rendered without starting the application flow."
        ),
        DashboardItem(
          title: "Long title edge case",
          subtitle: "A deliberately longer subtitle used to inspect wrapping and spacing."
        ),
        DashboardItem(
          title: "Third result",
          subtitle: "Deterministic scenario data."
        ),
      ])
    )
  }
}
