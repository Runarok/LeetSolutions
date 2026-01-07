class Solution {
public:
    int numBusesToDestination(vector<vector<int>>& routes, int source, int target) {
        if (source == target) return 0; // already at target

        int n = routes.size();

        // Step 1: Map each bus stop to the set of buses that go through it
        unordered_map<int, vector<int>> stopToBuses;
        for (int i = 0; i < n; ++i) {
            for (int stop : routes[i]) {
                stopToBuses[stop].push_back(i);
            }
        }

        // Step 2: BFS setup
        queue<int> q; // buses we can take
        vector<bool> visitedBus(n, false); // visited buses
        unordered_set<int> visitedStop;   // visited stops to avoid revisiting
        int busesTaken = 0;

        q.push(source);
        visitedStop.insert(source);

        // Step 3: BFS over stops
        while (!q.empty()) {
            int sz = q.size();
            busesTaken++;
            for (int i = 0; i < sz; ++i) {
                int stop = q.front(); q.pop();

                // Check all buses passing through this stop
                for (int bus : stopToBuses[stop]) {
                    if (visitedBus[bus]) continue;
                    visitedBus[bus] = true;

                    // Check all stops on this bus route
                    for (int nextStop : routes[bus]) {
                        if (nextStop == target) return busesTaken; // reached target
                        if (visitedStop.count(nextStop) == 0) {
                            visitedStop.insert(nextStop);
                            q.push(nextStop);
                        }
                    }
                }
            }
        }

        return -1; // target not reachable
    }
};
