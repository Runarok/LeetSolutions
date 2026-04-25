using System;

public class Solution {
    public int MaxDistance(int side, int[][] points, int k) {
        int n = points.Length;

        // ============================================
        // STEP 1: Convert 2D boundary → 1D perimeter
        // ============================================
        // We walk clockwise starting from (0,0)
        // and assign each point a distance along perimeter

        long[] pos = new long[n];

        for (int i = 0; i < n; i++) {
            int x = points[i][0], y = points[i][1];
            long p;

            if (y == 0) {
                // Bottom edge: (0,0) → (side,0)
                p = x;
            }
            else if (x == side) {
                // Right edge: (side,0) → (side,side)
                p = side + y;
            }
            else if (y == side) {
                // Top edge: (side,side) → (0,side)
                p = 2L * side + (side - x);
            }
            else {
                // Left edge: (0,side) → (0,0)
                p = 3L * side + (side - y);
            }

            pos[i] = p;
        }

        // Sort positions along perimeter
        Array.Sort(pos);

        // Total perimeter length
        long L = 4L * side;

        // ============================================
        // STEP 2: Duplicate array to simulate circular
        // ============================================
        // Example:
        // [1, 5, 9] → [1, 5, 9, 1+L, 5+L, 9+L]

        int total = n * 2;
        long[] ext = new long[total];

        for (int i = 0; i < n; i++) {
            ext[i] = pos[i];
            ext[i + n] = pos[i] + L;
        }

        // ============================================
        // STEP 3: Binary search on answer
        // ============================================
        long low = 0, high = 2L * side;

        while (low < high) {
            long mid = (low + high + 1) / 2;

            // Check if distance 'mid' is feasible
            if (CanPlace(mid, k, n, ext, L))
                low = mid;        // try bigger
            else
                high = mid - 1;  // reduce
        }

        return (int)low;
    }

    // ============================================
    // CHECK FUNCTION
    // ============================================
    // Can we pick k points such that each pair
    // has circular distance ≥ d ?
    private bool CanPlace(long d, int k, int n, long[] ext, long L) {

        // Try each point as starting point
        for (int start = 0; start < n; start++) {

            int cur = start;        // index of last chosen point
            long last = ext[start]; // position of last chosen
            int limit = start + n;  // we can only use n points ahead

            bool valid = true;

            // ============================================
            // Greedily pick remaining (k-1) points
            // ============================================
            for (int step = 1; step < k; step++) {

                // We need next point ≥ last + d
                long target = last + d;

                // Binary search for first index with value ≥ target
                int lo = cur + 1, hi = limit;

                while (lo < hi) {
                    int mid = (lo + hi) / 2;

                    if (ext[mid] < target)
                        lo = mid + 1;
                    else
                        hi = mid;
                }

                // If we ran out of points → fail
                if (lo == limit) {
                    valid = false;
                    break;
                }

                // Pick this point
                cur = lo;
                last = ext[cur];
            }

            // ============================================
            // Final check: circular wrap-around distance
            // ============================================
            // Ensure distance between LAST and FIRST ≥ d
            //
            // Circular distance = (first + L - last)
            //
            if (valid && (ext[start] + L - last >= d))
                return true;
        }

        return false;
    }
}