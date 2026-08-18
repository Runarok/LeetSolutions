class Solution {
    fun topKFrequent(nums: IntArray, k: Int): IntArray {

        // First, count how many times every number appears.
        //
        // Example:
        // nums = [1,1,1,2,2,3]
        //
        // frequency:
        // 1 -> 3
        // 2 -> 2
        // 3 -> 1
        val frequency = HashMap<Int, Int>()

        for (num in nums) {

            // If num already exists, increase its count.
            // Otherwise, start its count at 1.
            frequency[num] = frequency.getOrDefault(num, 0) + 1
        }

        // Create buckets based on frequency.
        //
        // buckets[1] = numbers that appear 1 time
        // buckets[2] = numbers that appear 2 times
        // buckets[3] = numbers that appear 3 times
        //
        // We need nums.size + 1 buckets because an element
        // could appear nums.size times.
        val buckets = Array(nums.size + 1) {
            mutableListOf<Int>()
        }

        // Put every number into the bucket corresponding
        // to its frequency.
        for ((num, count) in frequency) {
            buckets[count].add(num)
        }

        // Store the final k most frequent elements.
        val result = IntArray(k)

        // We start from the highest frequency because
        // those are the elements we want.
        var resultIndex = 0

        for (count in buckets.size - 1 downTo 1) {

            // Every number in this bucket has the same frequency.
            for (num in buckets[count]) {

                // Add this number to our answer.
                result[resultIndex] = num
                resultIndex++

                // Once we have k elements, we are done.
                if (resultIndex == k) {
                    return result
                }
            }
        }

        return result
    }
}