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
        let ternarySearchTree = TernarySearchTree()
        let benchmarker = Benchmarker(
            searchableDataSets: [
                trie,
                arrayDataSet,
                ternarySearchTree
            ],
            citiesRepository: LocalCityRepository()
        )

        Task {
            do {
                try await benchmarker.startBenchmark(prefix: "Basconcillos del Tozo", iterations: 10000)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
