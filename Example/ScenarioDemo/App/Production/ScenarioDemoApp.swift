import SwiftUI

@main
struct ScenarioDemoApp: App {
  var body: some Scene {
    WindowGroup {
      ApplicationRootView(
        container: AppContainerFactory.make(environment: .live)
      )
    }
  }
}
