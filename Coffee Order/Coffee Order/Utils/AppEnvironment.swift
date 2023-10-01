//
//  AppEnvironment.swift
//  Coffee Order
//
//  Created by MANAS VIJAYWARGIYA on 30/09/23.
//

import Foundation

enum Endpoints {
  case allOrders
  
  var path: String {
    switch self {
      case .allOrders:
        return "/test/orders" // /orders // /test/orders
    }
  }
}

struct Configuration {
  lazy var environment: AppEnvironment = {
    // read value from environment variable
    guard let env = ProcessInfo.processInfo.environment["ENV"] else { return AppEnvironment.dev }
    
    if env == "TEST" {
      return AppEnvironment.test
    } else if env == "PROD" {
      return AppEnvironment.prod
    }
    return AppEnvironment.dev
  }()
}

enum AppEnvironment: String {
  case dev
  case test
  case prod
  
  var baseURL: URL {
    switch self {
      case .dev:
        return URL(string: "https://island-bramble.glitch.me")!
      case .test:
        return URL(string: "https://island-bramble.glitch.me")!
      case .prod:
        return URL(string: "https://island-bramble.glitch.me")!
    }
  }
}
