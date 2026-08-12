import ScenarioKit
import SwiftUI

struct HomeEmptyScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "home.dashboard.empty",
    title: "Home – Empty",
    subtitle: "Successful response with no content",
    category: "Home",
    systemImage: "rectangle.grid.1x2"
  )

  func makeBody() -> some View {
    HomeScenarioHost(state: .empty)
  }
}
