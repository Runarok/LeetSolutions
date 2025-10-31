object Solution {
    def getSneakyNumbers(nums: Array[Int]): Array[Int] = {
        // Step 1: Create a mutable map to count how many times each number appears
        val countMap = scala.collection.mutable.Map[Int, Int]()
        
        // Step 2: Go through every number in nums and count it
        for (num <- nums) {
            // If the number is already in the map, increment its count
            // Otherwise, set its count to 1
            countMap(num) = countMap.getOrElse(num, 0) + 1
        }
        
        // Step 3: Collect all numbers that appeared more than once
        val sneakyNumbers = countMap.filter { case (_, count) => count > 1 }.keys.toArray
        
        // Step 4: Return the result (order doesn't matter)
        sneakyNumbers
    }
}
