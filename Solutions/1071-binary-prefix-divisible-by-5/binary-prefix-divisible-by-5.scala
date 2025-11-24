object Solution {

    /*
     * We are given a binary array nums, where nums(i) is either 0 or 1.
     * For each index i, we consider the binary number formed by nums[0..i].
     *
     * Example:
     * nums = [1, 0, 1]
     * i = 0 => x0 = 1
     * i = 1 => x1 = binary "10" = 2
     * i = 2 => x2 = binary "101" = 5
     *
     * We need to check, for every prefix, whether that prefix interpreted
     * as a binary integer is divisible by 5.
     *
     * ---------------------------------------------------------------
     * IMPORTANT OBSERVATION:
     * The prefix number can grow extremely large: length up to 100,000 bits.
     * A naive solution that builds the full number each time will overflow
     * and be too slow.
     *
     * Instead, we use modular arithmetic:
     *
     * If we have a number X (mod 5), and we append a bit b (0 or 1) at the end,
     * the new number becomes:
     *
     *   newX = X * 2 + b
     *
     * Therefore:
     *   newX mod 5 = (X * 2 + b) mod 5
     *
     * This allows us to safely track the number modulo 5 only.
     * The modulo 5 is ALWAYS in range 0–4, so no overflow and constant time.
     *
     * ---------------------------------------------------------------
     * TIME COMPLEXITY:
     * We process each number once, doing O(1) work → O(n).
     *
     * SPACE COMPLEXITY:
     * We return a list of size n → O(n).
     *
     * ---------------------------------------------------------------
     * APPROACH SUMMARY:
     * - Keep a running variable "mod" representing prefix % 5.
     * - For each bit, update mod = (mod * 2 + bit) % 5.
     * - If mod == 0, prefix is divisible by 5 → output true.
     * - Otherwise output false.
     */

    def prefixesDivBy5(nums: Array[Int]): List[Boolean] = {

        // Running modulo value of the prefix binary number
        var mod = 0

        // Use a mutable ListBuffer for efficient append
        val result = scala.collection.mutable.ListBuffer.empty[Boolean]

        // Process each bit in the input array
        for (bit <- nums) {

            // Update the modulo with the new bit.
            // Equivalent to shifting left by 1 (multiply by 2) and adding the new bit.
            mod = (mod * 2 + bit) % 5

            // If mod is zero, the prefix number is divisible by 5.
            // Save result.
            result += (mod == 0)
        }

        // Convert to immutable List as required by the function signature
        result.toList
    }
}
