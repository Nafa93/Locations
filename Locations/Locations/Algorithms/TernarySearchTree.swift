//
//  TernarySearchTree.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

class TSTNode {
    var char: Character
    var left: TSTNode?
    var middle: TSTNode?
    var right: TSTNode?
    var cities: [City] = []

    init(char: Character) {
        self.char = char
    }
}

class TernarySearchTree: SearchableDataSet {
    private var root: TSTNode?

    func insert(_ city: City) {
        guard !city.name.isEmpty else { return }
        root = insert(city, at: root, index: 0)
    }

    private func insert(_ city: City, at node: TSTNode?, index: Int) -> TSTNode {
        let name = city.name.lowercased()
        let char = name[name.index(name.startIndex, offsetBy: index)]
        let currentNode = node ?? TSTNode(char: char)

        if char < currentNode.char {
            currentNode.left = insert(city, at: currentNode.left, index: index)
        } else if char > currentNode.char {
            currentNode.right = insert(city, at: currentNode.right, index: index)
        } else {
            if index + 1 == name.count {
                currentNode.cities.append(city)
            } else {
                currentNode.middle = insert(city, at: currentNode.middle, index: index + 1)
            }
        }

        return currentNode
    }

    func search(prefix: String) -> [City] {
        guard !prefix.isEmpty else { return [] }
        let name = prefix.lowercased()
        guard let node = findNode(root, name, index: 0) else { return [] }

        var result = node.cities
        collect(node.middle, result: &result)
        return result
    }

    private func findNode(_ node: TSTNode?, _ name: String, index: Int) -> TSTNode? {
        guard let node = node else { return nil }
        let char = name[name.index(name.startIndex, offsetBy: index)]

        if char < node.char {
            return findNode(node.left, name, index: index)
        } else if char > node.char {
            return findNode(node.right, name, index: index)
        } else {
            if index == name.count - 1 {
                return node
            } else {
                return findNode(node.middle, name, index: index + 1)
            }
        }
    }

    private func collect(_ node: TSTNode?, result: inout [City]) {
        guard let node = node else { return }
        result.append(contentsOf: node.cities)
        collect(node.left, result: &result)
        collect(node.middle, result: &result)
        collect(node.right, result: &result)
    }
}
