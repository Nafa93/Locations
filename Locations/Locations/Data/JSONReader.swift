//
//  JSONReader.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

final class JSONReader {
    enum Errors: Error {
        case fileNotFound
        case unableToDecode
    }

    func readFromMainBundle<T: Decodable>(_ fileName: String, type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                continuation.resume(throwing: Errors.fileNotFound)
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                continuation.resume(returning: decodedData)
            } catch {
                continuation.resume(throwing: Errors.unableToDecode)
            }
        }
    }
}
