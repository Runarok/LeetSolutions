object Solution {
    def minOperations(nums: Array[Int], k: Int): Int = {

        // Compute the sum of the array
        val sum = nums.map(_.toLong).sum   // use Long to avoid overflow

        // Find the remainder when dividing by k
        val remainder = (sum % k).toInt

        // If remainder is 0, sum already divisible by k, so 0 operations.
        // Otherwise, we need 'remainder' number of operations,
        // because each operation reduces the total sum by exactly 1.
        if (remainder == 0) 0 else remainder
    }
}
