class Solution {
    func reductionOperations(_ nums: [Int]) -> Int {
        
        // Step 1: Sort the array
        let sortedNums = nums.sorted()
        
        // Step 2: Initialize variables
        var operations = 0        // total operations needed
        var countLarger = 0       // count of elements larger than current unique value
        
        // Step 3: Iterate from the end to the start
        for i in stride(from: sortedNums.count - 1, through: 1, by: -1) {
            
            // Step 4: Check if current number is different from previous
            if sortedNums[i] != sortedNums[i - 1] {
                
                // Step 5: Increment operations by the number of elements larger than current
                countLarger = sortedNums.count - i
                operations += countLarger
            }
            // If equal to previous, do nothing
        }
        
        return operations
    }
}
