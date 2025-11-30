object Solution {
    def minSubarray(nums: Array[Int], p: Int): Int = {

        val totalMod = nums.foldLeft(0L)((s, x) => (s + x) % p).toInt
        if (totalMod == 0) return 0

        val map = scala.collection.mutable.Map[Int, Int]()
        map(0) = -1

        var prefix = 0L
        var answer = nums.length

        for (i <- nums.indices) {

            prefix = (prefix + nums(i)) % p
            val prefixInt = prefix.toInt

            // Convert need to Int
            val need = (((prefix - totalMod) % p + p) % p).toInt

            if (map.contains(need)) {
                answer = math.min(answer, i - map(need))
            }

            // Update map
            map(prefixInt) = i
        }

        if (answer == nums.length) -1 else answer
    }
}
