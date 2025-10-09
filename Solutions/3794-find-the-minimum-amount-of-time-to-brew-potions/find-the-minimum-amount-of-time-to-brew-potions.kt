class Solution {
    fun minTime(skill: IntArray, mana: IntArray): Long {
        val n = skill.size   // Number of wizards
        val m = mana.size    // Number of potions

        // times[i] = the earliest time wizard i is ready to receive the next potion
        val times = LongArray(n) { 0L }

        // Iterate over each potion
        for (j in 0 until m) {
            var curTime = 0L  // Start time for the current potion

            // First, simulate the potion moving through all wizards
            for (i in 0 until n) {
                // Wizard i must wait until both:
                // 1. the potion reaches them (curTime)
                // 2. they are available (times[i])
                // The potion can only proceed at the max of these
                curTime = maxOf(curTime, times[i])

                // Add the brewing time for wizard i
                curTime += skill[i].toLong() * mana[j]
            }

            // Now curTime is the time when the last wizard finishes this potion
            // We need to update each wizard's availability time accordingly,
            // ensuring the next potion can be passed through seamlessly.

            // The last wizard's end time is simply curTime
            times[n - 1] = curTime

            // For the other wizards, we work backward:
            // Wizard i finished their work skill[i] * mana[j] before wizard i+1
            for (i in n - 2 downTo 0) {
                times[i] = times[i + 1] - skill[i + 1].toLong() * mana[j]
            }
        }

        // The total time is when the last wizard finished the last potion
        return times[n - 1]
    }
}
