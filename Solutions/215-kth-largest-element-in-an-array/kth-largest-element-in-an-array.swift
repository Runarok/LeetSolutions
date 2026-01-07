import Foundation

// Solution class
class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        // Step 1: Create a min-heap (priority queue) with a generic Heap structure
        // We use "<" for min-heap, so smallest element will always be at the top
        var minHeap = Heap<Int>(sort: <)
        
        // Step 2: Iterate over all numbers in the array
        for num in nums {
            // Step 2a: Insert the current number into the heap
            minHeap.insert(num) 
            
            // Step 2b: Maintain the heap size to be exactly k
            // If the heap grows bigger than k, remove the smallest element
            if minHeap.count > k {
                _ = minHeap.remove() // remove smallest element to keep only k largest
            }
        }
        
        // Step 3: After processing all numbers, the top of the min-heap is the kth largest
        return minHeap.peek() ?? 0
    }
}

// Generic heap structure
struct Heap<T> {
    var elements: [T] = []             // Array to store heap elements
    let sort: (T, T) -> Bool           // Sorting closure: defines min-heap or max-heap
    
    init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
    }
    
    // Returns the number of elements in the heap
    var count: Int { elements.count }
    
    // Peek at the top element of the heap (min or max)
    func peek() -> T? { elements.first }
    
    // Insert a new value into the heap
    mutating func insert(_ value: T) {
        elements.append(value)         // Add value at the end
        siftUp(elements.count - 1)     // Restore heap property by moving it up
    }
    
    // Remove the top element of the heap
    mutating func remove() -> T? {
        guard !elements.isEmpty else { return nil } // If heap is empty, return nil
        if elements.count == 1 { return elements.removeLast() } // Only one element
        let value = elements[0]          // Save the top value to return
        elements[0] = elements.removeLast() // Move last element to top
        siftDown(0)                       // Restore heap property by moving down
        return value                       // Return removed top element
    }
    
    // Sift up the element at index to maintain heap property
    mutating func siftUp(_ index: Int) {
        var child = index                // Start with the inserted element
        var parent = (child - 1) / 2     // Compute parent index
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent) // Swap if child violates heap
            child = parent                  // Move up
            parent = (child - 1) / 2        // Update parent index
        }
    }
    
    // Sift down the element at index to maintain heap property
    mutating func siftDown(_ index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1        // Left child index
            let right = 2 * parent + 2       // Right child index
            var candidate = parent           // Candidate to swap with
            
            // Compare with left child
            if left < elements.count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            
            // Compare with right child
            if right < elements.count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            
            // If parent is already in correct place, stop
            if candidate == parent { return }
            
            // Swap parent with candidate
            elements.swapAt(parent, candidate)
            parent = candidate               // Continue sifting down
        }
    }
}
