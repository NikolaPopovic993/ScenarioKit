import ScenarioKit
import SwiftUI

struct ProfilePremiumScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "profile.user.premium",
    title: "Profile – Premium User",
    subtitle: "Premium account presentation",
    category: "Profile",
    systemImage: "person.crop.circle"
  )

  func makeBody() -> some View {
    ProfileScenarioHost(
      profile: UserProfile(
        name: "Premium User",
        email: "premium@example.com",
        plan: "Premium",
        environmentDescription: "Isolated profile scenario"
      )
    )
  }
}
