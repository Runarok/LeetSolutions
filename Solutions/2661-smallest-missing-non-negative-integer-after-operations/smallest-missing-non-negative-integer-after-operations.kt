class Solution {
    fun findSmallestInteger(nums: IntArray, value: Int): Int {
        // Step 1: Create an array to count how many numbers we have for each modulo class (0 to value-1)
        // Each index 'i' in this array represents the count of numbers in 'nums' where num % value == i
        val count = IntArray(value)

        // Step 2: Populate the count array
        for (num in nums) {
            // We use ((num % value) + value) % value to correctly handle negative numbers
            // For example, (-1 % 5) == -1 in Kotlin, but we want it to be 4
            val mod = ((num % value) + value) % value
            count[mod]++
        }

        // Step 3: Try to build numbers starting from 0 upwards
        // At each step, if we have a number that can be transformed to match the current 'mex' modulo group,
        // we can use it to represent that number. If we run out of such numbers, we can't form that 'mex'.
        var mex = 0  // This will be our result: the smallest number we *can't* construct
        while (true) {
            val mod = mex % value  // Determine which modulo group is needed to form 'mex'
            
            if (count[mod] > 0) {
                // If we have at least one number in this mod group, use it to form 'mex'
                count[mod]--  // Use it once
                mex++         // Try the next number
            } else {
                // No number left in this mod group => can't form 'mex'
                break
            }
        }

        // Step 4: Return the MEX, which is the first number we couldn't construct
        return mex
    }
}
