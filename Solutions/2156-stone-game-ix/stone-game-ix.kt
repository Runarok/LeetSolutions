class Solution {
    fun stoneGameIX(stones: IntArray): Boolean {
        // count[0] = number of stones divisible by 3
        // count[1] = number of stones with remainder 1
        // count[2] = number of stones with remainder 2
        val count = IntArray(3)

        // We only care about each stone's remainder modulo 3.
        for (stone in stones) {
            count[stone % 3]++
        }

        val count0 = count[0]
        val count1 = count[1]
        val count2 = count[2]

        /*
         * Case 1: Number of remainder-0 stones is even.
         *
         * Stones with remainder 0 do not change the sum modulo 3.
         * They effectively cancel each other's effect on the turn order.
         *
         * Alice wins if there is at least one remainder-1 stone
         * AND at least one remainder-2 stone.
         *
         * Example: [1, 2]
         *
         * Alice picks 1 -> sum = 1
         * Bob must pick 2 -> sum = 0
         * Bob loses.
         */
        if (count0 % 2 == 0) {
            return count1 > 0 && count2 > 0
        }

        /*
         * Case 2: Number of remainder-0 stones is odd.
         *
         * The odd number of zero-remainder stones changes who gets
         * the final dangerous move.
         *
         * Alice can win only when one of the remainder groups is
         * at least 3 larger than the other.
         *
         * Example:
         * count1 = 4, count2 = 1
         * Difference = 3 -> Alice can force a win.
         */
        return kotlin.math.abs(count1 - count2) > 2
    }
}
