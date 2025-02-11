//
//  TopologicalSort.swift
//  Algorithms
//
//  Created by Bohdan Savych on 10/02/2025.
//

import Foundation

func topologicalSortBFS<T: Hashable>(_ graph: [T: [T]]) -> [T] {
    var inDegree = [T: Int]()
    var queue = [T]()
    var result = [T]()

    // Compute in-degree for each node
    // in-degree means the number of edges that enter a vertex in a directed graph
    for (_, neighbors) in graph {
        for neighbor in neighbors {
            inDegree[neighbor, default: 0] += 1
        }
    }

    // Enqueue nodes with 0 in-degree (no dependencies)
    for node in graph.keys {
        if inDegree[node] == nil {
            queue.append(node)
        }
    }

    while !queue.isEmpty {
        let node = queue.removeFirst()
        result.append(node)

        // Reduce in-degree of neighbors
        if let neighbors = graph[node] {
            for neighbor in neighbors {
                inDegree[neighbor, default: 0] -= 1
                if inDegree[neighbor] == 0 {
                    queue.append(neighbor)
                }
            }
        }
    }

    return result.count == graph.keys.count ? result : []  // If not all nodes processed, there's a cycle
}
