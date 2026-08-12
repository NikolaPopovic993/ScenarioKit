import Foundation

/// Controls which root is currently displayed by the internal application target.
@MainActor
public final class ScenarioSession: ObservableObject {
  public enum Mode: Equatable, Sendable {
    case launcher
    case application(environmentID: String)
    case mockedApplication
    case scenario(id: String)
  }

  @Published public private(set) var mode: Mode
  @Published public private(set) var lastEnvironmentID: String?

  /// The environment currently used by the real application, if that mode is active.
  public var selectedEnvironmentID: String? {
    guard case .application(let environmentID) = mode else {
      return nil
    }
    return environmentID
  }

  private let selectionStore: any ScenarioEnvironmentSelectionStoring

  public init(
    initialMode: Mode = .launcher,
    restoreLastEnvironmentOnLaunch: Bool = false,
    selectionStore: any ScenarioEnvironmentSelectionStoring
  ) {
    self.selectionStore = selectionStore
    let lastEnvironmentID = selectionStore.loadEnvironmentID()
    self.lastEnvironmentID = lastEnvironmentID

    if restoreLastEnvironmentOnLaunch, let lastEnvironmentID {
      self.mode = .application(environmentID: lastEnvironmentID)
    } else {
      self.mode = initialMode
    }
  }

  public func showLauncher() {
    mode = .launcher
  }

  public func start(environmentID: String) {
    selectionStore.save(environmentID: environmentID)
    lastEnvironmentID = environmentID
    mode = .application(environmentID: environmentID)
  }

  public func startMockedApplication() {
    mode = .mockedApplication
  }

  public func openScenario(id: String) {
    mode = .scenario(id: id)
  }
}
