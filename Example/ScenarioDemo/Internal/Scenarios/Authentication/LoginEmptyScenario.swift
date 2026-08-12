import ScenarioKit
import SwiftUI

struct LoginEmptyScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "authentication.login.empty",
    title: "Login – Empty",
    subtitle: "Initial login presentation state",
    category: "Authentication",
    systemImage: "person.badge.key"
  )

  func makeBody() -> some View {
    LoginScenarioHost(state: .idle)
  }
}
