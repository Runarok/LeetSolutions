class Solution {
    fun maximumTripletValue(nums: IntArray): Long {
        val n = nums.size
        // maxSuffix[i] will store the maximum value from nums[i] to the end of the array
        val maxSuffix = LongArray(n)
        maxSuffix[n - 1] = nums[n - 1].toLong() // Initialize the last element

        // Fill the maxSuffix array from right to left
        for (i in n - 2 downTo 0) {
            // For each index, store the maximum of the current element or the next maximum
            maxSuffix[i] = maxOf(maxSuffix[i + 1], nums[i].toLong())
        }

        var maxValue = 0L // To keep track of the maximum triplet value found
        var maxLeft = nums[0].toLong() // Maximum value to the left of the current index (j)

        // Iterate through the array from the second element to the second last element
        for (j in 1 until n - 1) {
            // Update the maxLeft to be the maximum value from the start up to index j-1
            maxLeft = maxOf(maxLeft, nums[j - 1].toLong())
            
            // Calculate the current triplet value using the formula:
            // (maxLeft - nums[j]) * maxSuffix[j + 1]
            val currentValue = (maxLeft - nums[j]) * maxSuffix[j + 1]
            
            // Update maxValue if the current triplet value is greater
            maxValue = maxOf(maxValue, currentValue)
        }

        return maxValue // Return the maximum triplet value found
    }
}
