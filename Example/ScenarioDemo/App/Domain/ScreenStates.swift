import Foundation

enum LoginScreenState: Equatable {
  case idle
  case loading
  case error(String)
}

enum HomeScreenState: Equatable {
  case loading
  case loaded([DashboardItem])
  case empty
  case error(String)
}

enum ProfileScreenState: Equatable {
  case loading
  case loaded(UserProfile)
  case error(String)
}
