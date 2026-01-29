class Solution {
    func minimumCost(
        _ source: String,
        _ target: String,
        _ original: [Character],
        _ changed: [Character],
        _ cost: [Int]
    ) -> Int {

        // A large number to represent "infinity"
        // We divide Int.max to avoid overflow when adding
        let INF = Int.max / 4

        // There are only 26 lowercase English letters
        // dist[i][j] = minimum cost to convert character (i + 'a') to (j + 'a')
        var dist = Array(
            repeating: Array(repeating: INF, count: 26),
            count: 26
        )

        // Cost to convert a character to itself is always 0
        for i in 0..<26 {
            dist[i][i] = 0
        }

        // Fill the initial direct conversion costs
        // Multiple conversions may exist between the same characters,
        // so we take the minimum cost
        for i in 0..<original.count {
            let from = Int(original[i].asciiValue! - Character("a").asciiValue!)
            let to = Int(changed[i].asciiValue! - Character("a").asciiValue!)
            dist[from][to] = min(dist[from][to], cost[i])
        }

        // Floyd–Warshall algorithm
        // This computes the minimum cost between all pairs of characters
        // by allowing intermediate transformations
        for k in 0..<26 {
            for i in 0..<26 {
                for j in 0..<26 {
                    if dist[i][k] + dist[k][j] < dist[i][j] {
                        dist[i][j] = dist[i][k] + dist[k][j]
                    }
                }
            }
        }

        // Convert source and target strings into arrays of characters
        let s = Array(source)
        let t = Array(target)

        // This will store the total minimum cost
        var totalCost = 0

        // Go through each character position
        for i in 0..<s.count {

            // Convert characters to indices 0–25
            let from = Int(s[i].asciiValue! - Character("a").asciiValue!)
            let to = Int(t[i].asciiValue! - Character("a").asciiValue!)

            // If conversion is impossible, return -1 immediately
            if dist[from][to] == INF {
                return -1
            }

            // Add the cost for this position
            totalCost += dist[from][to]
        }

        // Return the final minimum cost
        return totalCost
    }
}
