class Solution {
    func checkSubarraySum(_ nums: [Int], _ k: Int) -> Bool {

        // Step 1: Dictionary to store prefix sum modulo k
        // key = prefix sum % k
        // value = earliest index where this modulo occurred
        var modMap: [Int: Int] = [0: -1] // initialize 0 -> -1 to handle subarray starting from index 0

        // Step 2: Variable to store the running prefix sum
        var prefixSum = 0

        // Step 3: Iterate through the array
        for (i, num) in nums.enumerated() {

            prefixSum += num // add current number to prefix sum

            // Step 4: Compute modulo k
            let mod = prefixSum % k

            // Step 5: Check if this modulo has appeared before
            if let prevIndex = modMap[mod] {
                // If previous index exists, and subarray length >= 2
                if i - prevIndex >= 2 {
                    return true // found a good subarray
                }
            } else {
                // If this modulo hasn't appeared before, store it
                // we store the earliest index to maximize chance of length >= 2
                modMap[mod] = i
            }
        }

        // Step 6: If no good subarray found
        return false
    }
}
