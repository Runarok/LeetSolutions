
public class Solution {
    public IList<int> BusiestServers(int k, int[] arrival, int[] load) {

        // Stores the number of requests handled by each server.
        int[] handled = new int[k];

        // Stores all currently available servers in sorted order.
        // Initially, every server is available.
        SortedSet<int> available = new SortedSet<int>();

        for (int i = 0; i < k; i++) {
            available.Add(i);
        }

        // Min Heap stores busy servers.
        //
        // Element  = Server ID
        // Priority = Time when the server becomes available.
        //
        // The server with the earliest completion time
        // will always be at the top of the priority queue.
        //
        // We use long to prevent integer overflow.
        PriorityQueue<int, long> busy =
            new PriorityQueue<int, long>();

        // Process each incoming request.
        for (int i = 0; i < arrival.Length; i++) {

            // Current request arrival time.
            int currentTime = arrival[i];

            // STEP 1:
            // Release all servers whose requests have completed.
            //
            // If a server's completion time is <= current arrival time,
            // that server becomes available.
            //
            // Multiple servers might finish before this request arrives,
            // so we use a while loop.
            while (busy.Count > 0 &&
                   busy.TryPeek(out int server, out long completedAt) &&
                   completedAt <= currentTime) {

                // Remove the completed server from the priority queue.
                busy.Dequeue();

                // Add the server back to the available servers.
                available.Add(server);
            }

            // STEP 2:
            // If all servers are busy, drop this request.
            if (available.Count == 0) {
                continue;
            }

            // STEP 3:
            // Calculate the preferred server for this request.
            //
            // Request i prefers server i % k.
            int preferredServer = i % k;

            // Find the smallest available server ID
            // greater than or equal to preferredServer.
            int? selectedServer = null;

            // GetViewBetween gives us the available servers
            // in the range [preferredServer, k - 1].
            //
            // Since SortedSet is sorted, the first element
            // is the smallest available server in this range.
            foreach (int serverId in available.GetViewBetween(
                preferredServer, k - 1)) {

                selectedServer = serverId;
                break;
            }

            // STEP 4:
            // If no server was found in the range
            // [preferredServer, k - 1],
            // wrap around and select the smallest available server.
            if (selectedServer == null) {
                selectedServer = available.Min;
            }

            // Get the final server ID.
            int assignedServer = selectedServer.Value;

            // STEP 5:
            // Remove the selected server from available servers
            // because it is now busy handling this request.
            available.Remove(assignedServer);

            // Increment the number of requests handled by this server.
            handled[assignedServer]++;

            // STEP 6:
            // Calculate when this server will finish processing.
            //
            // Cast to long before addition to prevent integer overflow.
            long finishTime = (long)currentTime + load[i];

            // Add the server to the min heap.
            //
            // The server will become available again at finishTime.
            busy.Enqueue(assignedServer, finishTime);
        }

        // STEP 7:
        // Find the maximum number of requests handled by any server.
        int maxHandled = handled.Max();

        // STEP 8:
        // Collect all servers that handled the maximum number of requests.
        List<int> result = new List<int>();

        for (int i = 0; i < k; i++) {

            // Check whether this server handled the maximum requests.
            if (handled[i] == maxHandled) {
                result.Add(i);
            }
        }

        // Return the IDs of all busiest servers.
        return result;
    }
}
