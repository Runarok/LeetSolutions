// SegmentTree class to support range updates and queries efficiently
class SegmentTree {
    int n;            // size of the array
    int[] minTree;    // stores min value in each segment
    int[] maxTree;    // stores max value in each segment
    int[] lazy;       // lazy propagation array to store pending updates

    // Constructor: initializes arrays to 4*n (safe for segment tree)
    public SegmentTree(int n) {
        this.n = n;
        minTree = new int[4 * n];
        maxTree = new int[4 * n];
        lazy = new int[4 * n];
    }

    // Push the lazy updates from node down to its children
    private void push(int node, int start, int end) {
        if (lazy[node] != 0) {  // if there is a pending update
            // apply the lazy update to this node
            minTree[node] += lazy[node];
            maxTree[node] += lazy[node];

            // propagate to children if not a leaf
            if (start != end) {
                lazy[2 * node] += lazy[node];
                lazy[2 * node + 1] += lazy[node];
            }

            // clear the lazy value for this node
            lazy[node] = 0;
        }
    }

    // Range update: add 'val' to all elements in [l, r]
    public void updateRange(int node, int start, int end, int l, int r, int val) {
        push(node, start, end);  // ensure current node is up-to-date

        // completely outside the update range
        if (start > end || start > r || end < l) {
            return;
        }

        // completely inside the update range
        if (l <= start && end <= r) {
            lazy[node] += val;  // mark lazy update
            push(node, start, end);  // apply it immediately
            return;
        }

        // partially inside, partially outside → recurse into children
        int mid = (start + end) / 2;
        updateRange(2 * node, start, mid, l, r, val);
        updateRange(2 * node + 1, mid + 1, end, l, r, val);

        // update current node's min and max based on children
        minTree[node] = Math.min(minTree[2 * node], minTree[2 * node + 1]);
        maxTree[node] = Math.max(maxTree[2 * node], maxTree[2 * node + 1]);
    }

    // Find the **leftmost index** where the balance sum is zero
    public int findLeftmostZero(int node, int start, int end) {
        push(node, start, end);  // ensure node is up-to-date

        // if the entire segment is strictly positive or negative, no zero exists
        if (minTree[node] > 0 || maxTree[node] < 0) {
            return -1;
        }

        // leaf node → check if it's zero
        if (start == end) {
            return minTree[node] == 0 ? start : -1;
        }

        int mid = (start + end) / 2;

        // search in left child first (want leftmost zero)
        int left = findLeftmostZero(2 * node, start, mid);
        if (left != -1) return left;

        // if not found on the left, search right child
        return findLeftmostZero(2 * node + 1, mid + 1, end);
    }
}

// Solution class to compute longest balanced subarray
public class Solution {
    public int longestBalanced(int[] nums) {
        int n = nums.length;

        // Map to store the previous index of each number
        // This helps track **distinct numbers** in the subarray
        Map<Integer, Integer> prev = new HashMap<>();

        // Segment tree to maintain the balance (+1 for even, -1 for odd)
        SegmentTree st = new SegmentTree(n);

        int res = 0;  // stores the length of longest balanced subarray

        // Iterate over the array as the **right end** of subarrays
        for (int r = 0; r < n; r++) {
            int v = nums[r];
            int val = (v % 2 == 0) ? 1 : -1;  // +1 if even, -1 if odd

            // If this number has appeared before, remove its old contribution
            if (prev.containsKey(v)) {
                // subtract 'val' from all indices <= previous occurrence
                st.updateRange(1, 0, n - 1, 0, prev.get(v), -val);
            }

            // Add current number's contribution to all indices <= r
            st.updateRange(1, 0, n - 1, 0, r, val);

            // Update the last occurrence of this number
            prev.put(v, r);

            // Find leftmost index where the balance sum is zero
            int l = st.findLeftmostZero(1, 0, n - 1);

            // If such index exists and is within bounds, update result
            if (l != -1 && l <= r) {
                res = Math.max(res, r - l + 1);
            }
        }

        return res;  // return the length of the longest balanced subarray
    }
}
