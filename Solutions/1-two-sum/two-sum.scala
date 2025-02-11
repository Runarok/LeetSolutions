object Solution {
    def twoSum(nums: Array[Int], target: Int): Array[Int] = {
        // Create a hash map to store the indices of the elements
        val map = scala.collection.mutable.Map[Int, Int]()
        var result: Array[Int] = Array()

        // Iterate through the nums array
        for (i <- nums.indices) {
            val complement = target - nums(i)
            
            // If the complement is found in the map, store the indices in the result
            if (map.contains(complement)) {
                result = Array(map(complement), i)
            }
            
            // Otherwise, add the current number and its index to the map
            map(nums(i)) = i
        }
        
        // Return the result (it will be set to the correct pair when found)
        result
    }
}
