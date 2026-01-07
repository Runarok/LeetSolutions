class Solution {

    func minSubarray(_ nums: [Int], _ p: Int) -> Int {

        // Step 1: Calculate the total sum modulo p
        // If total sum is already divisible by p, we can return 0
        let totalMod = nums.reduce(0) { ($0 + $1) % p }
        if totalMod == 0 {
            return 0
        }

        // Step 2: Initialize a hash map to store prefix sums modulo p
        // Key: prefix sum modulo p, Value: index
        var prefixMap: [Int: Int] = [0: -1] // prefix sum 0 at index -1
        var currentMod = 0 // running prefix sum modulo p
        var minLength = nums.count // start with maximum possible length

        // Step 3: Loop through the array to find the smallest subarray
        for (i, num) in nums.enumerated() {

            // Update the running prefix sum modulo p
            currentMod = (currentMod + num) % p

            // Calculate the target modulo we want to remove
            // (currentMod - targetMod + p) % p ensures positive modulo
            let targetMod = (currentMod - totalMod + p) % p

            // If the target modulo has been seen before, we found a candidate subarray
            if let prevIndex = prefixMap[targetMod] {
                // Update minimum length if this subarray is smaller
                minLength = min(minLength, i - prevIndex)
            }

            // Store the current prefix sum modulo p in the map
            prefixMap[currentMod] = i
        }

        // Step 4: If minLength equals array length, it's impossible to remove (cannot remove whole array)
        return minLength == nums.count ? -1 : minLength
    }
}
