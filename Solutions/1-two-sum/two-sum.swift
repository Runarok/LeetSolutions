class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var numDict = [Int: Int]()  // Dictionary to store number and its index
        
        for (index, num) in nums.enumerated() {
            let complement = target - num
            
            if let complementIndex = numDict[complement] {
                // If complement is found, return its index and the current index
                return [complementIndex, index]
            }
            
            // Otherwise, add the current number and its index to the dictionary
            numDict[num] = index
        }
        
        // In case no solution is found, return an empty array (though the problem guarantees one solution)
        return []
    }
}
