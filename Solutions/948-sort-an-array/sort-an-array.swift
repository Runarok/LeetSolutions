class Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        // Make a mutable copy of nums because we'll sort in place
        var arr = nums
        
        let n = arr.count
        
        // Step 1: Build a max-heap from the array
        // We want the largest element at the root (index 0)
        for i in stride(from: n/2 - 1, through: 0, by: -1) {
            heapify(&arr, n, i)
        }
        
        // Step 2: Extract elements from heap one by one
        for i in stride(from: n - 1, through: 0, by: -1) {
            // Move current root (largest) to the end
            arr.swapAt(0, i)
            
            // Call heapify on the reduced heap
            heapify(&arr, i, 0)
        }
        
        return arr
    }
    
    // Heapify a subtree rooted at index 'i' in an array of size 'n'
    private func heapify(_ arr: inout [Int], _ n: Int, _ i: Int) {
        var largest = i               // Initialize largest as root
        let left = 2 * i + 1          // Left child index
        let right = 2 * i + 2         // Right child index
        
        // If left child is larger than root
        if left < n && arr[left] > arr[largest] {
            largest = left
        }
        
        // If right child is larger than current largest
        if right < n && arr[right] > arr[largest] {
            largest = right
        }
        
        // If largest is not root, swap and continue heapifying
        if largest != i {
            arr.swapAt(i, largest)
            heapify(&arr, n, largest) // Recursively heapify the affected subtree
        }
    }
}
