//
//  Trie.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord = false
    var cities: [City] = []
}

class Trie: SearchableDataSet {
    private let root = TrieNode()

    func insert(_ city: City) {
        var node = root
        let name = city.name.lowercased()

        for char in name {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }

        node.isEndOfWord = true
        node.cities.append(city)
    }

    func search(prefix: String) -> [City] {
        guard !prefix.isEmpty else { return [] }

        var node = root
        let lowerPrefix = prefix.lowercased()

        for char in lowerPrefix {
            guard let next = node.children[char] else { return [] }
            node = next
        }

        return collect(from: node)
    }

    private func collect(from node: TrieNode?) -> [City] {
        guard let node = node else { return [] }
        var result = node.cities

        for child in node.children.values {
            result += collect(from: child)
        }

        return result
    }
}
