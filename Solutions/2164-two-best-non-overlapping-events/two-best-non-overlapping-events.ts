function maxTwoEvents(events: number[][]): number {
    // Step 1: Sort events by their start time
    // This allows us to process events in chronological order
    events.sort((a, b) => a[0] - b[0]);

    // A min-heap (priority queue) that stores:
    // [endTime, value]
    // Ordered by endTime
    const heap: [number, number][] = [];

    // Keeps track of the maximum value among
    // all events that have already ended and do NOT overlap
    let bestPastValue = 0;

    // This will store the final answer
    let maxSum = 0;

    // Helper functions for the min-heap ---------------------

    // Push a new element into the heap
    const push = (item: [number, number]) => {
        heap.push(item);
        let i = heap.length - 1;

        // Bubble up
        while (i > 0) {
            const parent = Math.floor((i - 1) / 2);
            if (heap[parent][0] <= heap[i][0]) break;
            [heap[parent], heap[i]] = [heap[i], heap[parent]];
            i = parent;
        }
    };

    // Remove and return the smallest element (by endTime)
    const pop = (): [number, number] => {
        const top = heap[0];
        const last = heap.pop()!;
        if (heap.length > 0) {
            heap[0] = last;
            let i = 0;

            // Bubble down
            while (true) {
                let left = 2 * i + 1;
                let right = 2 * i + 2;
                let smallest = i;

                if (left < heap.length && heap[left][0] < heap[smallest][0]) {
                    smallest = left;
                }
                if (right < heap.length && heap[right][0] < heap[smallest][0]) {
                    smallest = right;
                }
                if (smallest === i) break;

                [heap[i], heap[smallest]] = [heap[smallest], heap[i]];
                i = smallest;
            }
        }
        return top;
    };

    // -------------------------------------------------------

    // Step 2: Iterate through each event in start-time order
    for (const [start, end, value] of events) {

        // Remove all events from the heap that end BEFORE this event starts
        // Since times are inclusive, we need end < start
        while (heap.length > 0 && heap[0][0] < start) {
            const [, pastValue] = pop();
            // Update the best value among valid past events
            bestPastValue = Math.max(bestPastValue, pastValue);
        }

        // Case 1: Take only this event
        maxSum = Math.max(maxSum, value);

        // Case 2: Combine this event with the best past non-overlapping event
        maxSum = Math.max(maxSum, value + bestPastValue);

        // Add this event to the heap for future comparisons
        push([end, value]);
    }

    return maxSum;
}
