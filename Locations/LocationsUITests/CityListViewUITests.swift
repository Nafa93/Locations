//
//  CityListViewUITests.swift
//  LocationsUITests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 23/05/2025.
//

import XCTest
@testable import Locations

final class CityListViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchEnvironment["UITestMode"] = "true"
    }

    func test_cityList_layout() throws {
        XCUIDevice.shared.orientation = .portrait

        app.launch()

        let textField = app.textFields["city_list.search"]
        let scrollView = app.scrollViews["city_list.scrollview"]
        let toggle = app.switches["city_list.favorites_toggle"]

        _ = scrollView.waitForExistence(timeout: 5)

        XCTAssertTrue(textField.exists)
        XCTAssertTrue(scrollView.exists)
        XCTAssertTrue(toggle.exists)
    }

    @MainActor
    func test_cityList_search() throws {
        XCUIDevice.shared.orientation = .portrait

        app.launch()

        let scrollView = app.scrollViews["city_list.scrollview"]
        let textField = app.textFields["city_list.search"]

        _ = scrollView.waitForExistence(timeout: 5)

        let buenosAires = scrollView.staticTexts["city_list_item.Buenos Aires, AR"]
        let sidney = scrollView.staticTexts["city_list_item.Sidney, AU"]

        let buenosAiresExists = buenosAires.waitForExistence(timeout: 5)
        let sidneyExists = sidney.waitForExistence(timeout: 5)

        XCTAssertTrue(buenosAiresExists)
        XCTAssertTrue(sidneyExists)

        textField.tap()

        textField.typeText("Buenos Aires")

        let returnButton = app.keyboards.buttons["Return"]

        _ = returnButton.waitForExistence(timeout: 5)

        returnButton.tap()

        _ = returnButton.waitForNonExistence(timeout: 5)

        let sidneyDoesNotExists = sidney.waitForNonExistence(timeout: 5)

        XCTAssertTrue(sidneyDoesNotExists)
    }

    @MainActor
    func test_cityList_Favorites() throws {
        XCUIDevice.shared.orientation = .portrait

        app.launch()

        let scrollView = app.scrollViews["city_list.scrollview"]
        let toggle = app.switches["city_list.favorites_toggle"]

        _ = scrollView.waitForExistence(timeout: 5)
        _ = toggle.waitForExistence(timeout: 5)

        let buenosAires = scrollView.staticTexts["city_list_item.Buenos Aires, AR"]
        let sidney = scrollView.staticTexts["city_list_item.Sidney, AU"]

        let buenosAiresExists = buenosAires.waitForExistence(timeout: 5)
        let sidneyExists = sidney.waitForExistence(timeout: 5)

        XCTAssertTrue(buenosAiresExists)
        XCTAssertTrue(sidneyExists)

        let buttons = app.buttons["city_list_item.Buenos Aires, AR"].firstMatch

        _ = buttons.waitForExistence(timeout: 5)

        buttons.tap()

        toggle.switches.firstMatch.tap()

        let sidneyDoesNotExists = sidney.waitForNonExistence(timeout: 5)

        XCTAssertTrue(sidneyDoesNotExists)
        XCTAssertTrue(buenosAires.exists)
    }
}
