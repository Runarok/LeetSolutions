import java.util.*;

class Solution {
    public List<Integer> largestDivisibleSubset(int[] nums) {
        Arrays.sort(nums); // Sort the input to ensure the divisibility condition can be checked in order

        int n = nums.length;
        int[] dp = new int[n];    // dp[i] stores the size of the largest divisible subset ending at nums[i]
        int[] parent = new int[n]; // parent[i] helps in reconstructing the subset

        Arrays.fill(dp, 1);       // Each number can at least form a subset of itself
        Arrays.fill(parent, -1);  // Initialize parent array with -1

        int maxSize = 1;          // The size of the largest subset found so far
        int maxIndex = 0;         // The index of the last element in the largest subset

        // Dynamic programming to find the largest subset
        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i] % nums[j] == 0) { // Check divisibility condition
                    if (dp[j] + 1 > dp[i]) {
                        dp[i] = dp[j] + 1;  // Update dp[i] if a larger subset is found
                        parent[i] = j;      // Update parent to reconstruct the subset later
                    }
                }
            }
            // Update the maximum subset size if needed
            if (dp[i] > maxSize) {
                maxSize = dp[i];
                maxIndex = i;
            }
        }

        // Reconstruct the largest divisible subset
        List<Integer> result = new ArrayList<>();
        while (maxIndex != -1) {
            result.add(nums[maxIndex]);
            maxIndex = parent[maxIndex];
        }

        Collections.reverse(result); // Reverse to get the correct order
        return result;
    }
}
