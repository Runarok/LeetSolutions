class Solution {
    func minCost(_ n: Int, _ edges: [[Int]]) -> Int {

        // ------------------------------------------------------------
        // Build graph
        // out[u]      = all normal outgoing edges from u: (v, cost)
        // incoming[u] = all incoming edges to u (used for reversal):
        //               original edge v -> u with cost w
        // ------------------------------------------------------------

        var out = Array(repeating: [(Int, Int)](), count: n)
        var incoming = Array(repeating: [(Int, Int)](), count: n)

        for e in edges {
            let u = e[0]
            let v = e[1]
            let w = e[2]

            // Normal edge u -> v with cost w
            out[u].append((v, w))

            // Incoming edge to v (from u), used for reversal
            incoming[v].append((u, w))
        }

        // ------------------------------------------------------------
        // Dijkstra setup
        // ------------------------------------------------------------

        // Large number representing "infinity"
        let INF = Int.max / 4

        // dist[i] = minimum cost to reach node i
        var dist = Array(repeating: INF, count: n)
        dist[0] = 0

        // Min-heap storing (cost, node)
        var heap = [(Int, Int)]()

        // ------------------------------------------------------------
        // Heap helper: push
        // ------------------------------------------------------------
        func push(_ item: (Int, Int)) {
            heap.append(item)
            var i = heap.count - 1

            // Bubble up
            while i > 0 {
                let parent = (i - 1) / 2
                if heap[parent].0 <= heap[i].0 { break }
                heap.swapAt(parent, i)
                i = parent
            }
        }

        // ------------------------------------------------------------
        // Heap helper: pop (extract minimum)
        // ------------------------------------------------------------
        func pop() -> (Int, Int)? {
            if heap.isEmpty { return nil }

            let res = heap[0]
            heap[0] = heap[heap.count - 1]
            heap.removeLast()

            var i = 0
            while true {
                let left = 2 * i + 1
                let right = 2 * i + 2
                var smallest = i

                if left < heap.count && heap[left].0 < heap[smallest].0 {
                    smallest = left
                }
                if right < heap.count && heap[right].0 < heap[smallest].0 {
                    smallest = right
                }

                if smallest == i { break }
                heap.swapAt(i, smallest)
                i = smallest
            }

            return res
        }

        // Start Dijkstra from node 0
        push((0, 0))

        // ------------------------------------------------------------
        // Main Dijkstra loop
        // ------------------------------------------------------------
        while let (cost, u) = pop() {

            // If we already found a better path, skip
            if cost > dist[u] { continue }

            // If destination is reached, we can return immediately
            if u == n - 1 {
                return cost
            }

            // --------------------------------------------------------
            // 1) Traverse normal outgoing edges: u -> v (cost w)
            // --------------------------------------------------------
            for (v, w) in out[u] {
                let newCost = cost + w
                if newCost < dist[v] {
                    dist[v] = newCost
                    push((newCost, v))
                }
            }

            // --------------------------------------------------------
            // 2) Use the switch at u
            //    Reverse incoming edge v -> u into u -> v
            //    Cost becomes 2 * w
            // --------------------------------------------------------
            for (v, w) in incoming[u] {
                let newCost = cost + 2 * w
                if newCost < dist[v] {
                    dist[v] = newCost
                    push((newCost, v))
                }
            }
        }

        // If destination was never reached
        return dist[n - 1] == INF ? -1 : dist[n - 1]
    }
}
