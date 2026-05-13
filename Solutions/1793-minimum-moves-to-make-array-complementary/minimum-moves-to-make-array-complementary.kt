class Solution {

    fun minMoves(nums: IntArray, limit: Int): Int {

        // ------------------------------------------------------------
        // Key Observation:
        //
        // For every mirrored pair:
        // (nums[i], nums[n-1-i])
        //
        // We want ALL pairs to finally have the SAME sum.
        //
        // Possible target sums:
        // from 2 to 2 * limit
        //
        // For each pair, we calculate:
        //
        // 0 moves  -> if target == currentSum
        // 1 move   -> if target can be achieved by changing ONE number
        // 2 moves  -> otherwise
        //
        // ------------------------------------------------------------
        //
        // Efficient Trick (Difference Array):
        //
        // Instead of checking every target sum for every pair
        // (which would be too slow),
        // we use range updates.
        //
        // For one pair (a, b):
        //
        // Let:
        // low  = min(a, b)
        // high = max(a, b)
        //
        // Current sum:
        // sum = a + b
        //
        // ------------------------------------------------------------
        //
        // Costs for this pair:
        //
        // target in:
        //
        // [2 ... low]                 -> 2 moves
        // [low+1 ... sum-1]           -> 1 move
        // [sum]                       -> 0 move
        // [sum+1 ... high+limit]      -> 1 move
        // [high+limit+1 ... 2*limit]  -> 2 moves
        //
        // ------------------------------------------------------------
        //
        // We start by assuming every target needs 2 moves.
        //
        // Then improve ranges using difference array:
        //
        // - subtract 1 for the range needing only 1 move
        // - subtract another 1 at exact sum (0 move total)
        //
        // ------------------------------------------------------------

        val diff = IntArray(2 * limit + 2)

        val n = nums.size

        // Process each mirrored pair
        for (i in 0 until n / 2) {

            val a = nums[i]
            val b = nums[n - 1 - i]

            val low = minOf(a, b)
            val high = maxOf(a, b)

            // Current exact sum of the pair
            val sum = a + b

            // --------------------------------------------------------
            // Initially:
            // every target sum costs 2 moves
            //
            // We will later reduce the cost in certain ranges.
            // --------------------------------------------------------

            // --------------------------------------------------------
            // Range where only 1 move is needed:
            // [low + 1, high + limit]
            //
            // Reduce cost by 1
            // --------------------------------------------------------
            diff[low + 1] -= 1
            diff[high + limit + 1] += 1

            // --------------------------------------------------------
            // Exact sum where 0 moves are needed:
            // target == sum
            //
            // Reduce one more move
            // --------------------------------------------------------
            diff[sum] -= 1
            diff[sum + 1] += 1
        }

        // ------------------------------------------------------------
        // Start with:
        // every pair costs 2 moves
        //
        // Number of pairs = n / 2
        //
        // So:
        // total base cost = 2 * (n/2) = n
        // ------------------------------------------------------------
        var currentMoves = n

        // Answer to minimize
        var answer = Int.MAX_VALUE

        // ------------------------------------------------------------
        // Sweep through all possible target sums
        // from 2 to 2*limit
        // ------------------------------------------------------------
        for (target in 2..2 * limit) {

            // Apply difference updates
            currentMoves += diff[target]

            // Keep minimum
            answer = minOf(answer, currentMoves)
        }

        return answer
    }
}