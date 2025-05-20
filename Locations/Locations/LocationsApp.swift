//
//  LocationsApp.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import SwiftUI

@main
struct LocationsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            TestView()
        }
    }
}


struct TestView: View {
    let jsonReader = JSONReader()

    var body: some View {
        Text("Hello world!")
            .onAppear {
                loadDataSet()
            }
    }

    func loadDataSet() {
        let trie = Trie()
        let arrayDataSet = ArrayDataSet()
        let binaryDataSet = BinarySearchDataSet()
        let ternarySearchTree = TernarySearchTree()

        if let dataSet: [City] = jsonReader.readJSONFromBundle("cities", type: [City].self) {
            Benchmarker.benchmark(label: "Adding to trie") {
                dataSet.forEach { trie.insert($0) }
            }

            Benchmarker.benchmark(label: "Searching in trie") {
                print("Found \(trie.search(prefix: "bas").count) words with trie")
            }

            Benchmarker.benchmark(label: "Adding to ternarySearchTree") {
                dataSet.forEach { ternarySearchTree.insert($0) }
            }

            Benchmarker.benchmark(label: "Searching ternarySearchTree") {
                print("Found \(ternarySearchTree.search(prefix: "bas").count) words with ternarySearchTree")
            }

            Benchmarker.benchmark(label: "Adding to arrayDataSet") {
                dataSet.forEach { arrayDataSet.insert($0) }
            }

            Benchmarker.benchmark(label: "Searching arrayDataSet") {
                print("Found \(arrayDataSet.search(prefix: "bas").count) words with arrayDataSet")
            }

            Benchmarker.benchmark(label: "Adding to binaryDataSet") {
                dataSet.forEach { binaryDataSet.insert($0) }
            }

            Benchmarker.benchmark(label: "Searching binaryDataSet") {
                print("Found \(binaryDataSet.search(prefix: "bas").count) words with binaryDataSet")
            }
        }
    }
}
