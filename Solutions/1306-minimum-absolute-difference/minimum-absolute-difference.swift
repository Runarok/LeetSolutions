class Solution {
    func minimumAbsDifference(_ arr: [Int]) -> [[Int]] {
        
        // Step 1: Sort the array in ascending order
        // Sorting helps because the minimum absolute difference will be between consecutive elements
        let sortedArr = arr.sorted()
        
        // Step 2: Initialize a variable to track the minimum absolute difference
        var minDiff = Int.max
        
        // Step 3: Iterate through consecutive elements to find the minimum difference
        for i in 1..<sortedArr.count {
            let diff = sortedArr[i] - sortedArr[i - 1] // difference between consecutive elements
            if diff < minDiff {
                minDiff = diff // update minDiff if we found a smaller one
            }
        }
        
        // Step 4: Initialize the result array
        var result: [[Int]] = []
        
        // Step 5: Iterate again to collect all pairs with the minimum difference
        for i in 1..<sortedArr.count {
            let diff = sortedArr[i] - sortedArr[i - 1] // difference between consecutive elements
            if diff == minDiff {
                result.append([sortedArr[i - 1], sortedArr[i]]) // add the pair to result
            }
        }
        
        // Step 6: Return the result array
        return result
    }
}
