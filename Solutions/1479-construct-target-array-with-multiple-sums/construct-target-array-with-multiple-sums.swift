import Foundation

class Solution {
    func isPossible(_ target: [Int]) -> Bool {
        // -----------------------------------------
        // Step 0: Edge case
        // If target has only 1 element, we can only succeed if it is 1
        // Because we start with [1] and sum is always 1
        // -----------------------------------------
        if target.count == 1 {
            return target[0] == 1
        }
        
        // -----------------------------------------
        // Step 1: Use a max-heap to always work with the largest element
        // Swift does not have a built-in max-heap, so we simulate it using a min-heap with negative values
        // We want the largest element first because that's the one that was most recently modified
        // -----------------------------------------
        var heap = target.map { -$0 }  // Negate to simulate max-heap
        heap.sort()                     // Min-heap behavior using sorted array for simplicity
        
        // Step 2: Calculate total sum of elements
        var total = target.reduce(0, +)
        
        // -----------------------------------------
        // Step 3: Keep reducing the largest element
        // Reverse the operations: largest element was created by sum of all elements before
        // We subtract previous sum to recover previous value
        // -----------------------------------------
        while true {
            // Get the largest element (remember we negated it)
            guard let maxNeg = heap.first else { break }  // If heap is empty, break
            let maxVal = -maxNeg  // Original value
            
            // Calculate sum of the rest
            let rest = total - maxVal  // sum of all other elements
            
            // -----------------------------------------
            // Step 3a: If largest element is 1, we can always build remaining ones
            // -----------------------------------------
            if maxVal == 1 || rest == 1 {
                return true
            }
            
            // -----------------------------------------
            // Step 3b: If rest is zero or larger element <= rest, impossible
            // -----------------------------------------
            if rest == 0 || maxVal <= rest {
                return false
            }
            
            // -----------------------------------------
            // Step 3c: Calculate previous value of largest element
            // This is done using modulo because multiple operations could have increased it
            // maxVal was obtained by repeatedly adding sum of rest
            // -----------------------------------------
            let prev = maxVal % rest
            
            // -----------------------------------------
            // Step 3d: If prev is zero or did not change, impossible
            // prev == 0 means largest element was exactly multiple of sum of rest, which cannot happen
            // -----------------------------------------
            if prev == 0 {
                return false
            }
            
            // -----------------------------------------
            // Step 3e: Update heap and total sum
            // Replace largest element with prev
            // -----------------------------------------
            heap[0] = -prev  // Negate to keep max-heap behavior
            total = rest + prev  // Update total sum
            
            // Step 3f: Re-sort heap to maintain max at front
            // For efficiency we could implement proper heap, but sorting is fine for clarity
            heap.sort()
        }
        
        // -----------------------------------------
        // If we exit loop, return true (should not reach here normally)
        // -----------------------------------------
        return true
    }
}
