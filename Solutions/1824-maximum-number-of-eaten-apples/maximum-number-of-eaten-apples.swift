class Solution {

    func eatenApples(_ apples: [Int], _ days: [Int]) -> Int {

        // Number of days where apples may grow
        let n = apples.count

        // Variable to store the total number of apples eaten
        var eaten = 0

        // Variable to track the current day
        var day = 0

        // Min-heap storing pairs of (expiryDay, appleCount)
        // The batch with the earliest expiry day is always on top
        var heap: [(Int, Int)] = []

        // Function to insert a new element into the min-heap
        func heapPush(_ item: (Int, Int)) {

            // Add the new item at the end of the heap
            heap.append(item)

            // Index of the newly added element
            var index = heap.count - 1

            // Move the element up until heap property is satisfied
            while index > 0 {

                // Compute the index of the parent node
                let parent = (index - 1) / 2

                // If parent already expires earlier or same day, stop
                if heap[parent].0 <= heap[index].0 {
                    break
                }

                // Swap the current node with its parent
                heap.swapAt(index, parent)

                // Update index to parent position
                index = parent
            }
        }

        // Function to remove and return the element with smallest expiry day
        func heapPop() -> (Int, Int)? {

            // If heap is empty, return nil
            if heap.isEmpty {
                return nil
            }

            // Save the root element (minimum expiry day)
            let minItem = heap[0]

            // Move the last element to the root
            heap[0] = heap[heap.count - 1]

            // Remove the last element
            heap.removeLast()

            // Index used for heapify-down
            var index = 0

            // Restore heap property by pushing element down
            while true {

                // Calculate left child index
                let left = 2 * index + 1

                // Calculate right child index
                let right = 2 * index + 2

                // Assume current index is smallest
                var smallest = index

                // Check if left child exists and expires earlier
                if left < heap.count && heap[left].0 < heap[smallest].0 {
                    smallest = left
                }

                // Check if right child exists and expires earlier
                if right < heap.count && heap[right].0 < heap[smallest].0 {
                    smallest = right
                }

                // If heap property is satisfied, stop
                if smallest == index {
                    break
                }

                // Swap current node with smallest child
                heap.swapAt(index, smallest)

                // Update index to continue heapifying
                index = smallest
            }

            // Return the removed minimum element
            return minItem
        }

        // Continue simulation while days remain
        // OR while there are apples still available in the heap
        while day < n || !heap.isEmpty {

            // If apples grow on the current day
            if day < n && apples[day] > 0 {

                // Calculate the day when these apples will rot
                let expiryDay = day + days[day]

                // Insert this batch into the heap
                heapPush((expiryDay, apples[day]))
            }

            // Remove all apple batches that have already rotted
            while let top = heap.first, top.0 <= day {

                // Remove rotten apples from heap
                _ = heapPop()
            }

            // If there are still apples available to eat
            if let top = heapPop() {

                // Increase the count of eaten apples
                eaten += 1

                // Extract expiry day of the batch
                let expiry = top.0

                // Reduce the apple count by one after eating
                let remaining = top.1 - 1

                // If apples remain in this batch
                if remaining > 0 {

                    // Push the remaining apples back into the heap
                    heapPush((expiry, remaining))
                }
            }

            // Move to the next day
            day += 1
        }

        // Return the total number of apples eaten
        return eaten
    }
}
