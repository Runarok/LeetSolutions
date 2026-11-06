
public class Solution {
    public int[] CountServers(int n, int[][] logs, int x, int[] queries) {

        // Step 1: Sort logs based on their request time.
        // logs[i][0] = server ID
        // logs[i][1] = request time
        Array.Sort(logs, (a, b) => a[1].CompareTo(b[1]));

        // Step 2: Store queries along with their original indices.
        // We sort queries by time to process them efficiently.
        int[][] sortedQueries = new int[queries.Length][];

        for (int i = 0; i < queries.Length; i++) {

            // Store:
            // [0] = query time
            // [1] = original index
            sortedQueries[i] = new int[] { queries[i], i };
        }

        // Sort queries based on their query time.
        Array.Sort(sortedQueries, (a, b) => a[0].CompareTo(b[0]));

        // Step 3: Create the answer array.
        // We will put answers at their original query positions.
        int[] answer = new int[queries.Length];

        // Step 4: Dictionary to maintain the frequency of each server.
        // Key   = Server ID
        // Value = Number of logs of that server inside the current window.
        Dictionary<int, int> frequency = new Dictionary<int, int>();

        // left and right pointers for the sliding window.
        int left = 0;
        int right = 0;

        // Number of distinct servers currently present in the window.
        int activeServers = 0;

        // Step 5: Process queries in sorted order.
        foreach (int[] query in sortedQueries) {

            int queryTime = query[0];
            int originalIndex = query[1];

            // Calculate the inclusive time window:
            // [queryTime - x, queryTime]
            int startTime = queryTime - x;

            // Step 6: Expand the window from the right.
            // Include all logs whose time is <= queryTime.
            while (right < logs.Length &&
                   logs[right][1] <= queryTime) {

                int serverId = logs[right][0];

                // If this server is not currently in the window,
                // it becomes an active server.
                if (!frequency.ContainsKey(serverId)) {
                    frequency[serverId] = 0;
                    activeServers++;
                }

                // Increase the frequency of this server.
                frequency[serverId]++;

                // Move the right pointer forward.
                right++;
            }

            // Step 7: Shrink the window from the left.
            // Remove logs whose time is LESS than startTime.
            //
            // Important:
            // The interval is inclusive, so logs at startTime
            // must remain inside the window.
            while (left < right &&
                   logs[left][1] < startTime) {

                int serverId = logs[left][0];

                // Decrease the frequency of the server.
                frequency[serverId]--;

                // If its frequency becomes zero,
                // no requests from this server remain
                // inside the current time window.
                if (frequency[serverId] == 0) {

                    // Remove the server from the dictionary.
                    frequency.Remove(serverId);

                    // Decrease the number of active servers.
                    activeServers--;
                }

                // Move the left pointer forward.
                left++;
            }

            // Step 8: Calculate servers with zero requests.
            //
            // Total servers = n
            // Active servers = servers that received requests
            //
            // Inactive servers = n - activeServers
            answer[originalIndex] = n - activeServers;
        }

        // Step 9: Return answers in the original query order.
        return answer;
    }
}
