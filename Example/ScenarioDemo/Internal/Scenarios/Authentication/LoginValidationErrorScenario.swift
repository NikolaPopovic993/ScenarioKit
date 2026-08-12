import ScenarioKit
import SwiftUI

struct LoginValidationErrorScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "authentication.login.validation-error",
    title: "Login – Validation Error",
    subtitle: "Inline validation without an API call",
    category: "Authentication",
    systemImage: "person.badge.key"
  )

  func makeBody() -> some View {
    LoginScenarioHost(state: .error("The email format is invalid."))
  }
}
