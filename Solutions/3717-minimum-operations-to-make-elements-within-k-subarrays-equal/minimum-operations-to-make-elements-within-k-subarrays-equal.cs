
public class Solution
{
    // Fenwick Tree for maintaining counts and sums.
    // We use two trees:
    // 1. countTree -> frequency of each number
    // 2. sumTree   -> sum of the numbers

    class Fenwick
    {
        private long[] tree;
        private int n;

        public Fenwick(int size)
        {
            n = size;
            tree = new long[n + 1];
        }

        // Add value at the given position.
        public void Add(int index, long value)
        {
            while (index <= n)
            {
                tree[index] += value;
                index += index & -index;
            }
        }

        // Returns prefix sum from 1 to index.
        public long Query(int index)
        {
            long sum = 0;

            while (index > 0)
            {
                sum += tree[index];
                index -= index & -index;
            }

            return sum;
        }

        // Find the position of the kth element.
        // This is used to find the median.
        public int Kth(long k)
        {
            int index = 0;

            int bit = 1;

            while ((bit << 1) <= n)
                bit <<= 1;

            for (; bit > 0; bit >>= 1)
            {
                int next = index + bit;

                if (next <= n && tree[next] < k)
                {
                    index = next;
                    k -= tree[next];
                }
            }

            return index + 1;
        }
    }

    public long MinOperations(int[] nums, int x, int k)
    {
        int n = nums.Length;

        // ------------------------------------------------
        // STEP 1: Coordinate compression.
        //
        // Convert the original values into sorted unique
        // values so Fenwick Tree can work with them.
        // ------------------------------------------------

        int[] sorted = (int[])nums.Clone();

        Array.Sort(sorted);

        int m = 0;

        for (int i = 0; i < n; i++)
        {
            if (m == 0 || sorted[i] != sorted[m - 1])
            {
                sorted[m++] = sorted[i];
            }
        }

        // Keep only unique sorted values.
        int[] values = new int[m];

        Array.Copy(sorted, values, m);

        // Find the compressed index of a number.
        int GetIndex(int value)
        {
            return Array.BinarySearch(values, value) + 1;
        }

        // ------------------------------------------------
        // STEP 2: Initialize Fenwick Trees.
        //
        // countTree maintains frequencies.
        // sumTree maintains actual sums.
        // ------------------------------------------------

        Fenwick countTree = new Fenwick(m);
        Fenwick sumTree = new Fenwick(m);

        long totalSum = 0;

        // Add an element to the current window.
        void Add(int value)
        {
            int idx = GetIndex(value);

            countTree.Add(idx, 1);

            sumTree.Add(idx, value);

            totalSum += value;
        }

        // Remove an element from the current window.
        void Remove(int value)
        {
            int idx = GetIndex(value);

            countTree.Add(idx, -1);

            sumTree.Add(idx, -value);

            totalSum -= value;
        }

        // ------------------------------------------------
        // STEP 3: Calculate median cost for each window.
        //
        // The median minimizes the sum of absolute
        // differences.
        //
        // We use Fenwick Kth() to find the median.
        // Prefix sums calculate the cost in O(log n).
        // ------------------------------------------------

        int windowCount = n - x + 1;

        long[] cost = new long[windowCount];

        for (int i = 0; i < x; i++)
        {
            Add(nums[i]);
        }

        for (int start = 0; start < windowCount; start++)
        {
            // Lower median position.
            int medianIndex = countTree.Kth((x + 1) / 2);

            long median = values[medianIndex - 1];

            // Number of elements <= median.
            long leftCount = countTree.Query(medianIndex);

            // Sum of elements <= median.
            long leftSum = sumTree.Query(medianIndex);

            // Number of elements > median.
            long rightCount = x - leftCount;

            // Sum of elements > median.
            long rightSum = totalSum - leftSum;

            // Cost of converting the entire window
            // into the median value.
            cost[start] =
                median * leftCount - leftSum
                + rightSum - median * rightCount;

            // Slide the window.
            if (start + x < n)
            {
                Remove(nums[start]);

                Add(nums[start + x]);
            }
        }

        // ------------------------------------------------
        // STEP 4: Dynamic Programming.
        //
        // prev[i] = minimum cost to select j-1
        //           non-overlapping windows in
        //           the first i elements.
        //
        // curr[i] = minimum cost to select j
        //           non-overlapping windows in
        //           the first i elements.
        //
        // We use rolling arrays to save memory.
        // ------------------------------------------------

        const long INF = long.MaxValue / 4;

        long[] prev = new long[n + 1];

        long[] curr = new long[n + 1];

        // Selecting zero windows costs zero.
        for (int i = 0; i <= n; i++)
        {
            prev[i] = 0;
        }

        // Calculate DP for 1 to k windows.
        for (int j = 1; j <= k; j++)
        {
            Array.Fill(curr, INF);

            for (int i = 1; i <= n; i++)
            {
                // OPTION 1:
                // Skip the current element.
                curr[i] = curr[i - 1];

                // OPTION 2:
                // Select a window ending at i - 1.
                //
                // Its starting index is i - x.
                //
                // Previous windows must end before
                // this starting index.
                if (i >= x)
                {
                    int start = i - x;

                    if (prev[start] != INF)
                    {
                        long take = prev[start] + cost[start];

                        curr[i] = Math.Min(curr[i], take);
                    }
                }
            }

            // Move to the next DP layer.
            (prev, curr) = (curr, prev);
        }

        return prev[n];
    }
}
