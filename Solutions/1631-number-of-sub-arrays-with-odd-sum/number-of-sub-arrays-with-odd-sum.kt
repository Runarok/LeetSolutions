class Solution {
    fun numOfSubarrays(arr: IntArray): Int {

        // Modulo value to prevent integer overflow
        val MOD = 1_000_000_007L

        // Count of prefix sums that are even
        // Initially, we consider the empty prefix sum (0), which is even
        var evenCount = 1L

        // Count of prefix sums that are odd
        var oddCount = 0L

        // Stores the current prefix sum
        var prefixSum = 0

        // Stores the total number of subarrays with odd sum
        var result = 0L

        // Traverse through every element in the array
        for (num in arr) {

            // Add the current element to the prefix sum
            prefixSum += num

            // Check whether the current prefix sum is odd or even
            if (prefixSum % 2 == 0) {

                // If current prefix sum is even,
                // an odd subarray can be formed by subtracting
                // a previous odd prefix sum.
                result += oddCount

                // Update the count of even prefix sums
                evenCount++

            } else {

                // If current prefix sum is odd,
                // an odd subarray can be formed by subtracting
                // a previous even prefix sum.
                result += evenCount

                // Update the count of odd prefix sums
                oddCount++
            }

            // Apply modulo to keep the result within limits
            result %= MOD
        }

        // Convert the result to Int as required by the function
        return result.toInt()
    }
}