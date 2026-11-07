import java.util.PriorityQueue;

class Solution {
    public int[] assignTasks(int[] servers, int[] tasks) {
        int n = servers.length;
        int m = tasks.length;
        int[] ans = new int[m];

        // 1. Min-heap for available (free) servers.
        // Sorted primarily by server weight (ascending), then by server index (ascending).
        // Each element stored is a long array: [weight, index]
        PriorityQueue<long[]> freeServers = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return Long.compare(a[0], b[0]); // Compare by weight
            }
            return Long.compare(a[1], b[1]);      // Tie-breaker: Compare by index
        });

        // 2. Min-heap for busy servers.
        // Sorted primarily by free time (ascending), then by weight, then by index.
        // Each element stored is a long array: [freeTime, weight, index]
        PriorityQueue<long[]> busyServers = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return Long.compare(a[0], b[0]); // Compare by when they become free
            }
            if (a[1] != b[1]) {
                return Long.compare(a[1], b[1]); // Tie-breaker: Compare by weight
            }
            return Long.compare(a[2], b[2]);      // Tie-breaker: Compare by index
        });

        // Initially, all servers are free at time 0. Populate the freeServers heap.
        for (int i = 0; i < n; i++) {
            freeServers.offer(new long[] { servers[i], i });
        }

        long currentTime = 0;

        // 3. Process each task one by one sequentially as they arrive at second `j`.
        for (int j = 0; j < m; j++) {
            // Time cannot move backwards; it's at least the task's arrival time `j`.
            currentTime = Math.max(currentTime, j);

            // If no servers are available at all, we must fast-forward time 
            // to when the earliest busy server finishes its task and becomes free.
            if (freeServers.isEmpty()) {
                currentTime = busyServers.peek()[0];
            }

            // 4. Free up servers: Move any servers from `busyServers` back to `freeServers` 
            // if their task completion time is less than or equal to the current time.
            while (!busyServers.isEmpty() && busyServers.peek()[0] <= currentTime) {
                long[] busyServer = busyServers.poll();
                // busyServer format: [freeTime, weight, index]
                // Push back into freeServers with: [weight, index]
                freeServers.offer(new long[] { busyServer[1], busyServer[2] });
            }

            // 5. Assign the current task `j` to the best available server 
            // (top of the `freeServers` heap, which has min weight / min index).
            long[] bestServer = freeServers.poll();
            long weight = bestServer[0];
            long index = bestServer[1];

            // Record the assigned server's index for task `j`
            ans[j] = (int) index;

            // 6. Push the server into the busy queue with its new release time: `currentTime + tasks[j]`
            busyServers.offer(new long[] { currentTime + tasks[j], weight, index });
        }

        return ans;
    }
}