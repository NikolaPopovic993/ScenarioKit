import UIKit

@MainActor
enum InternalScenarioShortcut {
  private static let type = "com.example.ScenarioDemo.Internal.scenarios"

  static func register(in application: UIApplication) {
    application.shortcutItems = [
      UIApplicationShortcutItem(
        type: type,
        localizedTitle: "Scenarios",
        localizedSubtitle: "Open environments and screen scenarios",
        icon: UIApplicationShortcutIcon(systemImageName: "square.grid.2x2")
      )
    ]
  }

  @discardableResult
  static func handle(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
    guard shortcutItem.type == type else {
      return false
    }

    InternalScenarioComposition.session.showLauncher()
    return true
  }
}
