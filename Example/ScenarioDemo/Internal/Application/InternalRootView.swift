import ScenarioKit
import SwiftUI

@MainActor
struct InternalRootView: View {
  var body: some View {
    ZStack(alignment: .topTrailing) {
      ScenarioKitRootView(
        session: InternalScenarioComposition.session,
        configuration: InternalScenarioComposition.launcherConfiguration,
        catalog: InternalScenarioComposition.catalog
      ) { environmentID in
        ApplicationRootView(
          container: AppContainerFactory.make(
            environment: AppEnvironment(rawValue: environmentID) ?? .development
          )
        )
      } makeMockedApplication: {
        ApplicationRootView(
          container: AppContainerFactory.makeMockedApplication()
        )
      }

      if InternalScenarioComposition.session.mode != .launcher {
        Button {
          InternalScenarioComposition.session.showLauncher()
        } label: {
          Image(systemName: "square.grid.2x2.fill")
            .font(.headline)
            .padding(10)
        }
        .buttonStyle(.borderedProminent)
        .padding(12)
        .accessibilityLabel("Return to Internal Launcher")
      }
    }
  }
}
