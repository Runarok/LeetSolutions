import java.util.*

class Solution {
    fun avoidFlood(rains: IntArray): IntArray {
        val n = rains.size
        val ans = IntArray(n) { 1 } // initialize with 1s; will overwrite where necessary
        val lakeToLastRainDay = mutableMapOf<Int, Int>()
        val dryDays = TreeSet<Int>() // stores indices of days we can dry

        for (i in rains.indices) {
            val lake = rains[i]
            if (lake > 0) {
                if (lakeToLastRainDay.containsKey(lake)) {
                    val lastRainDay = lakeToLastRainDay[lake]!!
                    val dryDay = dryDays.ceiling(lastRainDay + 1)
                    if (dryDay == null || dryDay >= i) {
                        return intArrayOf() // no valid dry day, flood happens
                    }
                    // Assign this dry day to dry lake
                    ans[dryDay] = lake
                    dryDays.remove(dryDay)
                }
                lakeToLastRainDay[lake] = i
                ans[i] = -1
            } else {
                dryDays.add(i)
                // We'll assign the actual lake later if needed
            }
        }

        // Any remaining dry days can be set to dry any lake (e.g., lake 1)
        for (day in dryDays) {
            ans[day] = 1 // arbitrary, safe default
        }

        return ans
    }
}
