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

final class when_app_is_launched_with_no_orders: XCTestCase {
  
  func test_ContentView_no_order_message_is_displayed() throws {
    let app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    XCTAssertEqual("No Orders Available!", app.staticTexts["noOrdersText"].label)
  }
}

final class when_adding_a_new_coffee_order: XCTestCase {
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

final class when_deleting_an_order: XCTestCase {
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

final class when_updating_an_existing_order: XCTestCase {
  private var app: XCUIApplication!
  
  override func setUp()  {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    
    // go to the add order screen
    app.buttons["addNewOrderButton"].tap()
    
    // write into textfields
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let placeOrderButton = app.buttons["placeOrderButton"]
    
    nameTextField.tap()
    nameTextField.typeText("Manas Vj")
    
    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Cold Coffee")
    
    priceTextField.tap()
    priceTextField.typeText("2.0")
    
    // place the order
    placeOrderButton.tap()
  }
  
  func test_should_update_order_successfully() {
    
    // go to the order screen
    let orderList = app.collectionViews["orderList"]
    orderList.buttons["orderNameText-coffeeNameAndSizeText-coffeePriceText"].tap()
    
    app.buttons["editOrderButton"].tap()
    
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let placeOrderButton = app.buttons["placeOrderButton"]
    
    let _ = nameTextField.waitForExistence(timeout: 10.0)
    nameTextField.tap(withNumberOfTaps: 3, numberOfTouches: 1)
    nameTextField.typeText("Manas E")
    
    let _ = coffeeNameTextField.waitForExistence(timeout: 10.0)
    coffeeNameTextField.tap(withNumberOfTaps: 3, numberOfTouches: 1)
    coffeeNameTextField.typeText("ColdCoffee E")
    
    let _ = priceTextField.waitForExistence(timeout: 10.0)
    priceTextField.tap(withNumberOfTaps: 3, numberOfTouches: 1)
    priceTextField.typeText("2.50")
    
    let _ = placeOrderButton.waitForExistence(timeout: 10.0)
    placeOrderButton.tap()
    
    XCTAssertEqual("ColdCoffee E", app.staticTexts["coffeeNameText"].label)
//    XCTAssertEqual("Manas E", app.staticTexts["coffeeBuyerNameText"].label)
  }
  
  // TEAR DOWN FUNCTIONS RUNS AND THEN DELETE ALL ORDERS FROM THE TEST DATABASE
  override func tearDown() {
    Task {
      guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
      let (_, _) = try! await URLSession.shared.data(from: url)
    }
  }
}
