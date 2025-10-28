object Solution {
    def countValidSelections(nums: Array[Int]): Int = {

        // Helper function to simulate the process
        def simulate(start: Int, dir: Int): Boolean = {
            // Make a copy so we don’t modify the original array
            val arr = nums.clone()
            var curr = start
            var direction = dir // +1 for right, -1 for left

            // Continue while inside bounds
            while (curr >= 0 && curr < arr.length) {
                if (arr(curr) == 0) {
                    // Move one step in current direction
                    curr += direction
                } else {
                    // Decrement value
                    arr(curr) -= 1
                    // Reverse direction
                    direction = -direction
                    // Step in new direction
                    curr += direction
                }
            }

            // After loop, check if all elements became 0
            arr.forall(_ == 0)
        }

        var count = 0

        // Try every index that has value 0
        for (i <- nums.indices if nums(i) == 0) {
            // Simulate starting left and right
            if (simulate(i, -1)) count += 1
            if (simulate(i, 1)) count += 1
        }

        count
    }
}
