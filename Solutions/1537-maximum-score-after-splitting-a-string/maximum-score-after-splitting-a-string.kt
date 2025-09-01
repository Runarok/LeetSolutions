class Solution {
    fun maxScore(s: String): Int {
        val n = s.length
        
        // prefixZero[i] will store the count of '0's in substring s[0..i-1]
        val prefixZero = IntArray(n + 1)
        
        // prefixOne[i] will store the count of '1's in substring s[0..i-1]
        val prefixOne = IntArray(n + 1)
        
        // Build prefix sums for zeros and ones
        for (i in 0 until n) {
            prefixZero[i + 1] = prefixZero[i] + if (s[i] == '0') 1 else 0
            prefixOne[i + 1] = prefixOne[i] + if (s[i] == '1') 1 else 0
        }
        
        // Total number of ones in the entire string
        val totalOnes = prefixOne[n]
        
        // Initialize maxScore to the smallest integer value
        var maxScore = Int.MIN_VALUE
        
        // Iterate over all possible split points
        // Split at i means:
        // Left substring = s[0..i-1], Right substring = s[i..n-1]
        for (i in 1 until n) {
            // Number of zeros in left substring = prefixZero[i]
            val zerosInLeft = prefixZero[i]
            
            // Number of ones in right substring = totalOnes - prefixOne[i]
            val onesInRight = totalOnes - prefixOne[i]
            
            // Calculate score for this split
            val score = zerosInLeft + onesInRight
            
            // Update maxScore if current score is higher
            maxScore = maxOf(maxScore, score)
        }
        
        // Return the maximum score found among all splits
        return maxScore
    }
}
