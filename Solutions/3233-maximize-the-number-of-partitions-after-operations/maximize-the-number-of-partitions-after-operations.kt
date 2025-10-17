class Solution {
    fun maxPartitionsAfterOperations(s: String, k: Int): Int {
        val n = s.length

        // Each element in `left` and `right` stores 3 values:
        // [0] = number of partitions so far
        // [1] = bitmask of distinct characters in the current partition
        // [2] = count of distinct characters in the current partition
        val left = Array(n) { IntArray(3) }
        val right = Array(n) { IntArray(3) }

        var num = 0
        var mask = 0
        var count = 0

        // Build the `left` array (prefix partitions)
        for (i in 0 until n - 1) {
            val bit = 1 shl (s[i] - 'a')
            if (mask and bit == 0) {
                // New character not seen before in this partition
                count++
                if (count <= k) {
                    mask = mask or bit
                } else {
                    // Too many distinct chars: start a new partition
                    num++
                    mask = bit
                    count = 1
                }
            }
            left[i + 1][0] = num
            left[i + 1][1] = mask
            left[i + 1][2] = count
        }

        // Reset for right side (suffix partitions)
        num = 0
        mask = 0
        count = 0

        // Build the `right` array (suffix partitions)
        for (i in n - 1 downTo 1) {
            val bit = 1 shl (s[i] - 'a')
            if (mask and bit == 0) {
                count++
                if (count <= k) {
                    mask = mask or bit
                } else {
                    num++
                    mask = bit
                    count = 1
                }
            }
            right[i - 1][0] = num
            right[i - 1][1] = mask
            right[i - 1][2] = count
        }

        var maxPartitions = 0

        // Try changing each character and calculate the resulting number of partitions
        for (i in 0 until n) {
            // Base segments = left segments + right segments + 2 (one partition for left, one for right)
            var seg = left[i][0] + right[i][0] + 2

            // Combine masks from left and right to get total distinct characters
            val totalMask = left[i][1] or right[i][1]
            val totalCount = Integer.bitCount(totalMask)

            if (left[i][2] == k && right[i][2] == k && totalCount < 26) {
                // Both sides are at capacity, but we can add 1 new char
                seg += 1
            } else if (minOf(totalCount + 1, 26) <= k) {
                // If changing a character doesn't exceed k, we may be over-counting
                seg -= 1
            }

            maxPartitions = maxOf(maxPartitions, seg)
        }

        return maxPartitions
    }
}
