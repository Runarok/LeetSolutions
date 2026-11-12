
object Solution {
    def longestMonotonicSubarray(nums: Array[Int]): Int = {

        // Length of the current strictly increasing subarray
        var inc = 1

        // Length of the current strictly decreasing subarray
        var dec = 1

        // Stores the maximum length found so far
        var maxLen = 1

        // Start checking from the second element
        for (i <- 1 until nums.length) {

            // If current element is greater than previous element,
            // we have a strictly increasing sequence
            if (nums(i) > nums(i - 1)) {

                // Extend the increasing subarray
                inc += 1

                // Decreasing sequence breaks, so reset it
                dec = 1

            }

            // If current element is smaller than previous element,
            // we have a strictly decreasing sequence
            else if (nums(i) < nums(i - 1)) {

                // Extend the decreasing subarray
                dec += 1

                // Increasing sequence breaks, so reset it
                inc = 1

            }

            // If both elements are equal,
            // neither increasing nor decreasing is possible
            else {

                // Reset both counters because the sequence breaks
                inc = 1
                dec = 1

            }

            // Update the maximum length after every comparison
            maxLen = math.max(maxLen, inc)
            maxLen = math.max(maxLen, dec)
        }

        // Return the longest increasing or decreasing subarray length
        maxLen
    }
}
