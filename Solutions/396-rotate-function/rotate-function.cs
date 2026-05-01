public class Solution {
    public int MaxRotateFunction(int[] nums) {
        int n = nums.Length;

        // Step 1: Compute total sum of array
        int sum = 0;

        // Step 2: Compute F(0)
        int f0 = 0;

        for (int i = 0; i < n; i++) {
            sum += nums[i];        // total sum
            f0 += i * nums[i];     // initial rotation value
        }

        // Store maximum result
        int max = f0;

        // Current rotation value (starts with F(0))
        int current = f0;

        // Step 3: Compute F(1) to F(n-1) using recurrence
        for (int k = 1; k < n; k++) {
            
            // Element moving from end to front after rotation
            int movedElement = nums[n - k];

            // Apply formula:
            // F(k) = F(k-1) + sum - n * movedElement
            current = current + sum - n * movedElement;

            // Update max if needed
            if (current > max) {
                max = current;
            }
        }

        return max;
    }
}