import ScenarioKit
import SwiftUI

struct ProfileFreeScenario: Scenario {
  let metadata = ScenarioMetadata(
    id: "profile.user.free",
    title: "Profile – Free User",
    subtitle: "Free account presentation",
    category: "Profile",
    systemImage: "person.crop.circle"
  )

  func makeBody() -> some View {
    ProfileScenarioHost(
      profile: UserProfile(
        name: "Free User",
        email: "free@example.com",
        plan: "Free",
        environmentDescription: "Isolated profile scenario"
      )
    )
  }
}
