import Foundation

struct AppContainer {
  let displayMode: String
  let repository: any AppRepository
}

enum AppContainerFactory {
  static func make(environment: AppEnvironment) -> AppContainer {
    AppContainer(
      displayMode: environment.title,
      repository: EnvironmentRepository(environment: environment)
    )
  }
}
