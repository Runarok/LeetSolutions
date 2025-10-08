class Solution {
    fun successfulPairs(spells: IntArray, potions: IntArray, success: Long): IntArray {
        val sortedPotions = potions.sorted()
        val m = potions.size
        val result = IntArray(spells.size)

        for (i in spells.indices) {
            val spell = spells[i]
            // Minimum potion strength required for success
            val minPotion = (success + spell - 1) / spell
            // Binary search to find the first potion >= minPotion
            var left = 0
            var right = m

            while (left < right) {
                val mid = left + (right - left) / 2
                if (sortedPotions[mid].toLong() < minPotion) {
                    left = mid + 1
                } else {
                    right = mid
                }
            }

            result[i] = m - left // all potions from left to end are valid
        }

        return result
    }
}
