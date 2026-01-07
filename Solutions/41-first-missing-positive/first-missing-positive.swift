class Solution {

    func firstMissingPositive(_ nums: [Int]) -> Int {

        // Make a mutable copy because the input array is immutable
        var nums = nums

        // Get the length of the array
        let n = nums.count

        // Step 1: Place each number in its "correct" position
        // i.e., 1 should be at index 0, 2 at index 1, etc.
        for i in 0..<n {

            // Keep swapping until:
            // 1) nums[i] is within [1, n]
            // 2) nums[i] is not already in its correct position
            // 3) Avoid infinite loop when duplicates exist
            while nums[i] > 0 && nums[i] <= n && nums[i] != nums[nums[i] - 1] {

                // Swap nums[i] with the number at its correct position
                let correctIndex = nums[i] - 1
                nums.swapAt(i, correctIndex)
            }
        }

        // Step 2: Find the first index where the number is incorrect
        for i in 0..<n {

            // If the number at index i is not i + 1, then i + 1 is missing
            if nums[i] != i + 1 {
                return i + 1
            }
        }

        // Step 3: If all positions are correct, the missing number is n + 1
        return n + 1
    }
}
