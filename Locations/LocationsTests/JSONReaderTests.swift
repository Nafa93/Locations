//
//  JSONReaderTests.swift
//  LocationsTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import XCTest
@testable import Locations

final class JSONReaderTests: XCTestCase {
    var sut: JSONReader!

    override func setUpWithError() throws {
        sut = JSONReader()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_whenFileDoesNotExist_throwsFileNotFound() async {
        // Given
        let fileName = "Not existing file"

        do {
            //When
            _ = try await sut.readFromMainBundle(fileName, type: [City].self)
        } catch let error as JSONReader.Errors {
            // Then
            XCTAssertEqual(error, .fileNotFound)
        } catch {
            XCTFail("Error thrown missmatch")
        }
    }

    func test_whenDataTypeMismatches_throwsUnableToDecode() async {
        // Given
        let fileName = "cities-small"

        do {
            // When
            _ = try await sut.readFromMainBundle(fileName, type: [String].self)
        } catch let error as JSONReader.Errors {
            // Then
            XCTAssertEqual(error, .unableToDecode)
        } catch {
            XCTFail("Error thrown missmatch")
        }
    }

    func test_whenFileExists_andTypeMatches_dataIsDecoded() async {
        // Given
        let fileName = "cities-small"

        do {
            // When
            let dataSet = try await sut.readFromMainBundle(fileName, type: [City].self)

            // Then
            XCTAssertTrue(dataSet.count > 0)
        } catch {
            XCTFail("Unexpected error")
        }
    }
}
