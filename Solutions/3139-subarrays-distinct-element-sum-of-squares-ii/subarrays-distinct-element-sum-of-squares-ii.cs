using System;
using System.Collections.Generic;

public class Solution {
    public int SumCounts(int[] nums) {
        int n = nums.Length;
        int mod = 1000000007;

        // Segment tree arrays
        // sum1[i] stores the sum of distinct counts in the range
        // sum2[i] stores the sum of squares of distinct counts in the range
        // lazy[i] stores the pending range increment
        long[] sum1 = new long[4 * n];
        long[] sum2 = new long[4 * n];
        long[] lazy = new long[4 * n];

        void Apply(int node, int l, int r, long val) {
            // (cnt + val)^2 = cnt^2 + 2*val*cnt + val^2
            long len = (r - l + 1);
            sum2[node] = (sum2[node] + 2 * val * sum1[node] + val * val % mod * len) % mod;
            sum1[node] = (sum1[node] + val * len) % mod;
            lazy[node] = (lazy[node] + val) % mod;
        }

        void PushDown(int node, int l, int r) {
            if (lazy[node] != 0) {
                int mid = (l + r) / 2;
                Apply(2 * node, l, mid, lazy[node]);
                Apply(2 * node + 1, mid + 1, r, lazy[node]);
                lazy[node] = 0;
            }
        }

        void Update(int node, int l, int r, int ql, int qr, long val) {
            if (ql <= l && r <= qr) {
                Apply(node, l, r, val);
                return;
            }
            PushDown(node, l, r);
            int mid = (l + r) / 2;
            if (ql <= mid) Update(2 * node, l, mid, ql, qr, val);
            if (qr > mid) Update(2 * node + 1, mid + 1, r, ql, qr, val);
            
            sum1[node] = (sum1[2 * node] + sum1[2 * node + 1]) % mod;
            sum2[node] = (sum2[2 * node] + sum2[2 * node + 1]) % mod;
        }

        Dictionary<int, int> lastSeen = new Dictionary<int, int>();
        long totalSum = 0;

        for (int r = 0; r < n; r++) {
            int l = 0;
            if (lastSeen.ContainsKey(nums[r])) {
                l = lastSeen[nums[r]] + 1;
            }
            lastSeen[nums[r]] = r;

            // Update range [l, r] by adding 1 to distinct counts
            Update(1, 0, n - 1, l, r, 1);

            // sum2[1] holds the sum of squares of all subarray distinct counts ending at or before current index
            totalSum = (totalSum + sum2[1]) % mod;
        }

        return (int)totalSum;
    }
}
