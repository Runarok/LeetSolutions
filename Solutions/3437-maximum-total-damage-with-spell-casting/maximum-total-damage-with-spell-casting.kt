import java.util.*
import kotlin.collections.*

class Solution {
    fun maximumTotalDamage(power: IntArray): Long {
        // Step 1: Count frequency of each spell damage
        val count = mutableMapOf<Int, Long>()
        for (dmg in power) {
            count[dmg] = count.getOrDefault(dmg, 0L) + 1
        }

        // Step 2: Convert to sorted list of (damageValue, frequency)
        // Add a dummy entry (-1e9, 0) to simplify indexing (like vec[0] = dummy)
        val vec = mutableListOf<Pair<Int, Long>>()
        vec.add(Pair(-(1e9).toInt(), 0L))  // Dummy base case
        for (key in count.keys.sorted()) {
            vec.add(Pair(key, count[key]!!))
        }

        val n = vec.size

        // Step 3: Initialize DP array, where f[i] is max total damage up to i-th element
        val f = LongArray(n) { 0L }

        // mx tracks the best previous value we can take without conflict
        var mx = 0L

        // j is the left pointer for our sliding window
        var j = 1

        // Step 4: Loop over each damage value starting from index 1 (since 0 is dummy)
        for (i in 1 until n) {
            val currDmg = vec[i].first
            val currCount = vec[i].second
            // Move j forward while there's no conflict
            // We want to find the farthest back we can go without overlapping
            // with current value (difference > 2)
            while (j < i && vec[j].first < currDmg - 2) {
                mx = maxOf(mx, f[j])
                j++
            }
            // Option: Take current damage (currDmg * currCount) + best non-conflicting
            f[i] = mx + currDmg.toLong() * currCount
        }

        // Step 5: Return the maximum value in DP array
        return f.maxOrNull() ?: 0L
    }
}
