import Foundation

class Solution {
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        // -----------------------------------------
        // Step 0: Initialize result array to store pairs
        // -----------------------------------------
        var result: [[Int]] = []  // This will store the k pairs with smallest sums
        
        // -----------------------------------------
        // Step 0b: Edge case: if either array is empty or k is 0, return empty result
        // -----------------------------------------
        if nums1.isEmpty || nums2.isEmpty || k == 0 {
            return result  // Nothing to do if one array is empty
        }
        
        // -----------------------------------------
        // Step 1: Initialize a min-heap
        // We'll store tuples (sum, index1, index2)
        // sum = nums1[index1] + nums2[index2]
        // index1 = index in nums1
        // index2 = index in nums2
        // This heap will always give us the smallest sum on top
        // -----------------------------------------
        var heap: [(sum: Int, i: Int, j: Int)] = []
        
        // -----------------------------------------
        // Step 1a: Helper function to push into heap
        // Maintains min-heap property
        // -----------------------------------------
        func pushHeap(_ item: (Int, Int, Int)) {
            heap.append(item)  // Add the new item at the end
            var idx = heap.count - 1  // Start at the last element
            
            // Bubble up until min-heap property is restored
            while idx > 0 {
                let parent = (idx - 1) / 2  // Parent index in binary heap
                if heap[parent].sum <= heap[idx].sum { break } // If parent <= child, done
                heap.swapAt(parent, idx)  // Swap with parent
                idx = parent  // Move index up to parent
            }
        }
        
        // -----------------------------------------
        // Step 1b: Helper function to pop the smallest element from heap
        // Returns nil if heap is empty
        // -----------------------------------------
        func popHeap() -> (sum: Int, i: Int, j: Int)? {
            if heap.isEmpty { return nil }  // Nothing to pop
            
            let top = heap[0]  // Save the smallest element (root)
            heap[0] = heap[heap.count - 1]  // Move last element to root
            heap.removeLast()  // Remove the last element
            var idx = 0  // Start bubbling down from root
            
            // Bubble down to restore min-heap property
            while true {
                let left = idx * 2 + 1  // Left child index
                let right = idx * 2 + 2 // Right child index
                var smallest = idx  // Assume current index is smallest
                
                // Compare with left child
                if left < heap.count && heap[left].sum < heap[smallest].sum {
                    smallest = left
                }
                
                // Compare with right child
                if right < heap.count && heap[right].sum < heap[smallest].sum {
                    smallest = right
                }
                
                if smallest == idx { break } // Heap property satisfied
                heap.swapAt(idx, smallest)  // Swap with smallest child
                idx = smallest  // Move down to child index
            }
            
            return top  // Return the smallest element
        }
        
        // -----------------------------------------
        // Step 2: Initialize heap with first column of pairs
        // Pair nums1[i] with nums2[0] for all i up to k
        // Why only first element of nums2? Because arrays are sorted,
        // nums2[0] guarantees the smallest sum for each nums1[i]
        // -----------------------------------------
        let n1 = nums1.count  // Length of nums1
        let n2 = nums2.count  // Length of nums2
        for i in 0..<min(n1, k) {  // Only need first k elements from nums1
            pushHeap((nums1[i] + nums2[0], i, 0))  // Push pair (nums1[i], nums2[0])
        }
        
        // -----------------------------------------
        // Step 3: Extract k smallest pairs from heap
        // -----------------------------------------
        while result.count < k, let top = popHeap() {
            let i = top.i  // Index in nums1
            let j = top.j  // Index in nums2
            
            result.append([nums1[i], nums2[j]])  // Add this pair to result
            
            // If there's a next element in nums2, push new pair (i, j+1)
            // This keeps exploring the next possible smallest sum for this nums1[i]
            if j + 1 < n2 {
                pushHeap((nums1[i] + nums2[j + 1], i, j + 1))
            }
        }
        
        // -----------------------------------------
        // Step 4: Return the list of k smallest pairs
        // -----------------------------------------
        return result
    }
}
