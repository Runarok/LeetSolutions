class Solution {

    func waysToMakeFair(_ nums: [Int]) -> Int {

        // Step 1: Calculate total sums for even and odd indices
        // These will help us know the remaining sums after removing an element
        var totalEven = 0
        var totalOdd = 0

        for (i, num) in nums.enumerated() {
            if i % 2 == 0 {
                totalEven += num // even index
            } else {
                totalOdd += num // odd index
            }
        }

        // Step 2: Initialize prefix sums for even and odd indices
        var prefixEven = 0 // sum of even indices up to current index (excluding current)
        var prefixOdd = 0  // sum of odd indices up to current index (excluding current)

        // Step 3: Initialize result counter
        var count = 0

        // Step 4: Iterate through each index to simulate removal
        for (i, num) in nums.enumerated() {

            // Remove current number from the remaining totals
            if i % 2 == 0 {
                totalEven -= num
            } else {
                totalOdd -= num
            }

            // After removal, the indices shift:
            // new even sum = prefixEven + totalOdd (because odd-indexed numbers after i become even)
            // new odd sum = prefixOdd + totalEven (even-indexed numbers after i become odd)
            if prefixEven + totalOdd == prefixOdd + totalEven {
                count += 1 // fair array after removing this index
            }

            // Add current number to prefix sums before moving to next index
            if i % 2 == 0 {
                prefixEven += num
            } else {
                prefixOdd += num
            }
        }

        // Step 5: Return the total number of indices that make the array fair
        return count
    }
}
