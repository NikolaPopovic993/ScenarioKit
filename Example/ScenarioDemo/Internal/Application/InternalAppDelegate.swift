import UIKit

@main
@MainActor
final class InternalAppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        InternalScenarioShortcut.register(in: application)
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(
            name: "Internal Window Configuration",
            sessionRole: connectingSceneSession.role
        )
        configuration.delegateClass = InternalSceneDelegate.self
        return configuration
    }
}
