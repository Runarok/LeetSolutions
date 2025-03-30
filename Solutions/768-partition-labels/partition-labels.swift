class Solution {
    func partitionLabels(_ s: String) -> [Int] {
        // Step 1: Record the last occurrence of each character
        var lastOccurrence = [Character: Int]()
        for (index, char) in s.enumerated() {
            lastOccurrence[char] = index
        }
        
        var result = [Int]()
        var start = 0
        var end = 0
        
        // Step 2: Iterate through the string to create partitions
        for (index, char) in s.enumerated() {
            end = max(end, lastOccurrence[char] ?? index)
            
            // If we've reached the end of the current partition
            if index == end {
                result.append(index - start + 1)
                start = index + 1
            }
        }
        
        return result
    }
}
