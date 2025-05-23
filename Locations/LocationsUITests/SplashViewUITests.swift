//
//  SplashViewUITests.swift
//  LocationsUITests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 23/05/2025.
//

import XCTest

final class SplashViewUITests: XCTestCase {
    func test_splashViewIsDisplayed() throws {
        let app = XCUIApplication()
        app.launch()

        let title = app.staticTexts["splash.title"]

        let titleExists = title.waitForExistence(timeout: 5)

        XCTAssertTrue(titleExists)
    }
}
