class Solution {
    func putMarbles(_ weights: [Int], _ k: Int) -> Int {
        let n = weights.count
        
        // Step 1: Collect the sum of adjacent marble pairs.
        // For example, if weights = [1, 3, 5, 1], pairWeights will be [4, 8, 6].
        var pairWeights: [Int] = []
        for i in 0..<n-1 {
            pairWeights.append(weights[i] + weights[i + 1])
        }
        
        // Step 2: Sort the pairWeights in ascending order.
        // This helps us easily find the smallest and largest sums.
        pairWeights.sort()
        
        // Step 3: Calculate the difference between the largest (k - 1) and smallest (k - 1) sums.
        // The idea is to maximize the score by picking the largest k - 1 sums and minimize the score
        // by picking the smallest k - 1 sums.
        var answer = 0
        for i in 0..<k-1 {
            // Add the largest (n - 2 - i)th element (for max score) and subtract the smallest ith element (for min score).
            answer += pairWeights[n - 2 - i] - pairWeights[i]
        }
        
        // Step 4: Return the final difference between the maximum and minimum scores.
        return answer
    }
}
