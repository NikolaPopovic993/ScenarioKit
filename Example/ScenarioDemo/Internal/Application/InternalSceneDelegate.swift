import SwiftUI
import UIKit

@MainActor
final class InternalSceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else {
      return
    }

    if let shortcutItem = connectionOptions.shortcutItem {
      _ = InternalScenarioShortcut.handle(shortcutItem)
    }

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: InternalRootView())
    self.window = window
    window.makeKeyAndVisible()
  }

  func windowScene(
    _ windowScene: UIWindowScene,
    performActionFor shortcutItem: UIApplicationShortcutItem,
    completionHandler: @escaping (Bool) -> Void
  ) {
    completionHandler(InternalScenarioShortcut.handle(shortcutItem))
  }
}
