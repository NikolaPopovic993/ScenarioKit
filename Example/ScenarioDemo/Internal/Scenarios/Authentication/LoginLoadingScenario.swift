import ScenarioKit
import SwiftUI

struct LoginLoadingScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "authentication.login.loading",
    title: "Login – Loading",
    subtitle: "Loading state with disabled controls",
    category: "Authentication",
    systemImage: "person.badge.key"
  )

  func makeBody() -> some View {
    LoginScenarioHost(state: .loading)
  }
}
