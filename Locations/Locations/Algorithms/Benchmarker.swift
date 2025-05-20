//
//  Benchmarker.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

final class Benchmarker {
    static func benchmark(label: String, iterations: Int = 1, _ block: () -> Void) {
        let start = CFAbsoluteTimeGetCurrent()

        for _ in 0..<iterations {
            block()
        }

        let end = CFAbsoluteTimeGetCurrent()
        let total = end - start
        print("\(label): \(total / Double(iterations)) seconds per run (\(iterations)x)")
    }
}
