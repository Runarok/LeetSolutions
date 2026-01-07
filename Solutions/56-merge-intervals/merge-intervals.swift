class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        
        // Step 1: Return empty if input is empty
        guard !intervals.isEmpty else { return [] }
        
        // Step 2: Sort intervals by start time
        let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
        
        // Step 3: Initialize merged array
        var merged: [[Int]] = []
        
        // Step 4: Iterate through each interval
        for interval in sortedIntervals {
            
            // Step 5: If merged is empty, just append the interval
            if merged.isEmpty {
                merged.append(interval)
            } else {
                // Step 6: Get the last interval in merged
                var last = merged.removeLast()
                
                // Step 7: Check for overlap
                if interval[0] <= last[1] {
                    // Merge intervals: update the end to max of both
                    last[1] = max(last[1], interval[1])
                    merged.append(last)
                } else {
                    // No overlap, append both intervals
                    merged.append(last)
                    merged.append(interval)
                }
            }
        }
        
        // Step 8: Return the merged intervals
        return merged
    }
}
