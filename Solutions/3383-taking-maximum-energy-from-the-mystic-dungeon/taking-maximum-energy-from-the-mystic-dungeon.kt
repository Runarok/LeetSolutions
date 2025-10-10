class Solution {
    fun maximumEnergy(energy: IntArray, k: Int): Int {
        val n = energy.size
        
        // dp[i] will store the maximum energy we can collect
        // starting at index i and jumping every k steps
        val dp = IntArray(n)
        
        // This will keep track of the best (maximum) energy path
        var maxEnergy = Int.MIN_VALUE

        // We process the energy array from right to left
        // because we want to compute dp[i + k] before dp[i]
        for (i in n - 1 downTo 0) {

            // If jumping from i by k goes out of bounds,
            // then we can't jump anymore, so dp[i] is just energy[i]
            if (i + k >= n) {
                dp[i] = energy[i]
            } else {
                // Otherwise, add current energy to the result of the next jump
                dp[i] = energy[i] + dp[i + k]
            }

            // Update the overall maximum energy if dp[i] is better
            maxEnergy = maxOf(maxEnergy, dp[i])
        }

        // Return the best possible energy we can collect
        return maxEnergy
    }
}
