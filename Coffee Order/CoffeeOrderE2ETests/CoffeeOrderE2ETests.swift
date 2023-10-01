//
//  CoffeeOrderE2ETests.swift
//  CoffeeOrderE2ETests
//
//  Created by MANAS VIJAYWARGIYA on 01/10/23.
//

import XCTest

// Naming Structure : test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming Structure : test_[struct or class]_[variable or function]_[expected result]

// Testing Structure: Given, When, Then
// Given
// When
// Then

final class CoffeeOrderE2ETests: XCTestCase {
  
  func test_ContentView_no_order_message_is_displayed() throws {
    let app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    XCTAssertEqual("No Orders Available!", app.staticTexts["noOrdersText"].label)
  }
}
