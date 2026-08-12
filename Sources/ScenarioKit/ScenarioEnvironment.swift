import Foundation

/// UI description of a real application environment. The package only stores its ID;
/// the host application decides how that ID creates an API client and composition root.
public struct ScenarioEnvironment: Identifiable, Hashable, Sendable {
  public let id: String
  public let title: String
  public let subtitle: String
  public let systemImage: String
  public let requiresConfirmation: Bool
  public let confirmationTitle: String?
  public let confirmationMessage: String?

  public init(
    id: String,
    title: String,
    subtitle: String,
    systemImage: String,
    requiresConfirmation: Bool = false,
    confirmationTitle: String? = nil,
    confirmationMessage: String? = nil
  ) {
    self.id = id
    self.title = title
    self.subtitle = subtitle
    self.systemImage = systemImage
    self.requiresConfirmation = requiresConfirmation
    self.confirmationTitle = confirmationTitle
    self.confirmationMessage = confirmationMessage
  }
}
