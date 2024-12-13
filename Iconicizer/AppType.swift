//
//  AppType.swift
//  Iconicizer
//
//  Created by John Florian on 12/13/24.
//

import CoreFoundation

enum AppType: String, Identifiable, CaseIterable {
  case iOS = "iOS"
  case macOS = "macOS"
  case watchOS = "watchOS"
  
  var id: String { self.rawValue }
  
  var iconSizes: [CGFloat] {
    switch self {
    case .iOS:
      [20, 29, 40, 60, 76, 83.5, 1024]
    case .macOS:
      [16, 32, 128, 256, 512]
    case .watchOS:
      [20, 29, 40, 60, 1024]
    }
  }
  
  var scaleFactors: [CGFloat] {
    switch self {
    case .iOS:
      [1, 2, 3]
    case .macOS:
      [1, 2]
    case .watchOS:
      [1, 2, 3]
    }
  }
}
