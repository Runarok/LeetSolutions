public class Solution {
    public int MinimumHammingDistance(int[] source, int[] target, int[][] allowedSwaps) {
        int n = source.Length;

        // Step 1: Initialize Union-Find (Disjoint Set)
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i; // each node is its own parent initially
        }

        // Find with path compression
        int Find(int x) {
            if (parent[x] != x) {
                parent[x] = Find(parent[x]); // path compression
            }
            return parent[x];
        }

        // Union operation
        void Union(int a, int b) {
            int rootA = Find(a);
            int rootB = Find(b);
            if (rootA != rootB) {
                parent[rootB] = rootA; // attach one root to another
            }
        }

        // Step 2: Build connected components
        foreach (var swap in allowedSwaps) {
            Union(swap[0], swap[1]);
        }

        // Step 3: Group indices by their root (component)
        var groups = new Dictionary<int, List<int>>();
        for (int i = 0; i < n; i++) {
            int root = Find(i);
            if (!groups.ContainsKey(root)) {
                groups[root] = new List<int>();
            }
            groups[root].Add(i);
        }

        int hammingDistance = 0;

        // Step 4: Process each component independently
        foreach (var group in groups.Values) {
            // Count frequency of elements in source within this component
            var freq = new Dictionary<int, int>();

            foreach (int index in group) {
                int val = source[index];
                if (!freq.ContainsKey(val)) freq[val] = 0;
                freq[val]++;
            }

            // Try to match with target
            foreach (int index in group) {
                int val = target[index];

                // If we have this value in source (within this component), use it
                if (freq.ContainsKey(val) && freq[val] > 0) {
                    freq[val]--; // matched successfully
                } else {
                    // cannot match → contributes to Hamming distance
                    hammingDistance++;
                }
            }
        }

        return hammingDistance;
    }
}