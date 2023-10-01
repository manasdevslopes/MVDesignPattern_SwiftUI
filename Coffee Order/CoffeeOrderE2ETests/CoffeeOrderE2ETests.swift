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

final class AddCoffeeViewE2ETests: XCTestCase {
  private var app: XCUIApplication!
  
  // Called before running each test
  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    
    // go to Place order screen
    app.buttons["addNewOrderButton"].tap()
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let placeOrderButton = app.buttons["placeOrderButton"]
    
    nameTextField.tap()
    nameTextField.typeText("Manas")
    
    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("MacD Coffee")
    
    priceTextField.tap()
    priceTextField.typeText("1.2")
    
    // Place the order
    placeOrderButton.tap()
  }
  
  func test_AddCoffeeView_should_display_coffee_order_in_list_successfully() throws {
    XCTAssertEqual("Manas", app.staticTexts["orderNameText"].label)
    XCTAssertEqual("MacD Coffee (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
    XCTAssertEqual("$1.20", app.staticTexts["coffeePriceText"].label)
  }
  
  // Called after running each test
  override func tearDown() {
    Task {
      guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
      let (_, _) = try! await URLSession.shared.data(from: url)
    }
  }
}

final class DeleteCoffeeViewE2ETests: XCTestCase {
  private var app: XCUIApplication!
  
  // Called before running each test
  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    
    // go to Place order screen
    app.buttons["addNewOrderButton"].tap()
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let placeOrderButton = app.buttons["placeOrderButton"]
    
    nameTextField.tap()
    nameTextField.typeText("Manas")
    
    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("MacD Coffee")
    
    priceTextField.tap()
    priceTextField.typeText("1.2")
    
    // Place the order
    placeOrderButton.tap()
  }
  
  func test_ContentView_should_delete_order_successfully() throws {
    let collectionViewsQuery = XCUIApplication().collectionViews
    let cellsQuery = collectionViewsQuery.cells
    let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
    element.swipeLeft()
    collectionViewsQuery.buttons["Delete"].tap()
    
    let orderList = app.collectionViews["orderList"]
    XCTAssertEqual(0, orderList.cells.count)
    
  }
  
  // Called after running each test
  override func tearDown() {
    Task {
      guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
      let (_, _) = try! await URLSession.shared.data(from: url)
    }
  }
}
