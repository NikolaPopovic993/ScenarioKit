import Foundation

/// Describes a single isolated presentation scenario displayed by the launcher.
public struct ScenarioMetadata: Identifiable, Hashable, Sendable {
  public let id: String
  public let title: String
  public let subtitle: String?
  public let category: String
  public let systemImage: String

  public init(
    id: String,
    title: String,
    subtitle: String? = nil,
    category: String,
    systemImage: String = "rectangle.on.rectangle"
  ) {
    self.id = id
    self.title = title
    self.subtitle = subtitle
    self.category = category
    self.systemImage = systemImage
  }
}
