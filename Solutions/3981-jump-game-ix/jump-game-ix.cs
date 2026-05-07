public class Solution
{
    public int[] MaxValue(int[] nums)
    {
        int n = nums.Length;

        // ------------------------------------------------------------
        // Key Observation
        // ------------------------------------------------------------
        //
        // A jump between i and j is possible exactly when:
        //
        //   i < j AND nums[i] > nums[j]
        //
        // Why?
        //
        // If i < j:
        //   - i -> j is allowed because nums[j] < nums[i]
        //   - j -> i is ALSO allowed because nums[i] > nums[j]
        //
        // So every valid jump is actually bidirectional.
        //
        // That means:
        //   Reachability = Connected Component
        //
        // ------------------------------------------------------------
        // Another Important Observation
        // ------------------------------------------------------------
        //
        // Two neighboring regions are disconnected ONLY when:
        //
        //   max(left part) <= min(right part)
        //
        // because then NO inversion exists across the boundary.
        //
        // Example:
        //   [2,1 | 3]
        //
        // left max  = 2
        // right min = 3
        //
        // 2 <= 3  => no edges across boundary
        //
        // Therefore:
        //   Connected components are contiguous segments.
        //
        // For every segment:
        //   answer for all indices = maximum value inside that segment.
        //
        // ------------------------------------------------------------
        // Plan
        // ------------------------------------------------------------
        //
        // 1. Build suffix minimum array.
        // 2. Scan from left to right.
        // 3. Whenever:
        //
        //      prefixMax <= suffixMin[i + 1]
        //
        //    we end the current component.
        //
        // 4. Fill all indices in that component with component maximum.
        //
        // Time Complexity: O(n)
        // Space Complexity: O(n)
        // ------------------------------------------------------------

        // suffixMin[i] = minimum value from i to n-1
        int[] suffixMin = new int[n];

        suffixMin[n - 1] = nums[n - 1];

        for (int i = n - 2; i >= 0; i--)
        {
            suffixMin[i] = Math.Min(nums[i], suffixMin[i + 1]);
        }

        int[] ans = new int[n];

        // Start index of current connected component
        int start = 0;

        // Maximum value inside current component
        int componentMax = nums[0];

        // Maximum value seen so far while scanning
        int prefixMax = nums[0];

        for (int i = 0; i < n; i++)
        {
            // Update running values
            prefixMax = Math.Max(prefixMax, nums[i]);
            componentMax = Math.Max(componentMax, nums[i]);

            // --------------------------------------------------------
            // Determine whether current component ends here.
            //
            // Component ends if:
            //
            //   prefixMax <= suffixMin[i + 1]
            //
            // meaning:
            //   every value on the left <= every value on the right
            //
            // so NO inversion exists across the boundary.
            // --------------------------------------------------------

            bool isBoundary =
                (i == n - 1) ||
                (prefixMax <= suffixMin[i + 1]);

            if (isBoundary)
            {
                // Fill all indices in this component
                // with the maximum value of the component.
                for (int j = start; j <= i; j++)
                {
                    ans[j] = componentMax;
                }

                // Start next component
                start = i + 1;

                if (start < n)
                {
                    componentMax = nums[start];
                    prefixMax = Math.Max(prefixMax, nums[start]);
                }
            }
        }

        return ans;
    }
}