import ScenarioKit
import SwiftUI

struct HomeErrorScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "home.dashboard.error",
    title: "Home – Error",
    subtitle: "Mocked server failure presentation",
    category: "Home",
    systemImage: "rectangle.grid.1x2"
  )

  func makeBody() -> some View {
    HomeScenarioHost(state: .error("The mocked endpoint returned a server error."))
  }
}
