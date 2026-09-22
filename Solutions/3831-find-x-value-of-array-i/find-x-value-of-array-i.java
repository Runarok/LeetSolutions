class Solution {
    public long[] resultArray(int[] nums, int k) {
        // --- 1. INITIALIZATION ---
        // result[x] will store the total number of subarrays whose product % k == x.
        // We use 'long' because the count of subarrays can quickly exceed the 32-bit Integer limit.
        long[] result = new long[k];
        
        // dp[r] tracks how many subarrays *ending at the previous index* have a product % k == r.
        long[] dp = new long[k];
        
        // --- 2. CORE ITERATION ---
        // We iterate through every number in the array from left to right.
        for (int num : nums) {
            // nextDp will store the remainder frequencies for subarrays ending at the CURRENT element.
            long[] nextDp = new long[k];
            
            // OPTION A: Start a brand-new subarray using just the current 'num'.
            // The remainder of this single-element subarray is (num % k).
            int currentRemainder = num % k;
            nextDp[currentRemainder]++;
            
            // OPTION B: Extend existing subarrays that ended at the previous element.
            // We look at every valid remainder 'r' from the previous step.
            for (int r = 0; r < k; r++) {
                if (dp[r] > 0) {
                    // If we extend a previous subarray that had remainder 'r',
                    // its new product remainder becomes (r * num) % k.
                    int newRemainder = (int) (((long) r * num) % k);
                    
                    // All 'dp[r]' subarrays get extended together, so we pass their count over.
                    nextDp[newRemainder] += dp[r];
                }
            }
            
            // --- 3. STATE UPDATE & RESULT COLLECTION ---
            // Move our calculated states into 'dp' to prepare for the next element in 'nums'.
            dp = nextDp;
            
            // Because every valid remainder tracked in 'dp' represents a valid subarray 
            // ending at our current index, we add these counts directly to our global answers.
            for (int r = 0; r < k; r++) {
                result[r] += dp[r];
            }
        }
        
        // Return the final frequency array of size k.
        return result;
    }
}
