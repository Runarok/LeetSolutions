import java.util.Arrays;

class Solution {
    public int sortableIntegers(int[] nums) {
        int n = nums.length;
        
        // Step 1: Create a sorted version of the array to know what each chunk 
        // should look like in non-decreasing order.
        int[] sortedNums = nums.clone();
        Arrays.sort(sortedNums);
        
        long totalSum = 0;
        
        // Step 2: Iterate through all possible integers k from 1 to n.
        for (int k = 1; k <= n; k++) {
            // k must divide n to be able to partition nums into equal subarrays of length k.
            if (n % k != 0) {
                continue;
            }
            
            boolean kValid = true;
            
            // Step 3: Check each consecutive subarray (chunk) of length k.
            for (int i = 0; i < n; i += k) {
                // Extract the current chunk from nums and the corresponding chunk from sortedNums.
                int[] s = Arrays.copyOfRange(nums, i, i + k);
                int[] c = Arrays.copyOfRange(sortedNums, i, i + k);
                
                // Sub-check 1: Verify that the multiset of elements in chunk s matches chunk c.
                int[] sSorted = s.clone();
                Arrays.sort(sSorted);
                if (!Arrays.equals(sSorted, c)) {
                    kValid = false;
                    break;
                }
                
                // Sub-check 2: Verify that chunk s is a valid cyclic rotation of a sorted array.
                // A cyclically rotated sorted array can have at most one "drop" (where s[j] > s[j+1] circularly).
                int drops = 0;
                for (int j = 0; j < k; j++) {
                    if (s[j] > s[(j + 1) % k]) {
                        drops++;
                    }
                }
                
                if (drops > 1) {
                    kValid = false;
                    break;
                }
            }
            
            // If all chunks satisfy the conditions, k is sortable.
            if (kValid) {
                totalSum += k;
            }
        }
        
        return (int) totalSum;
    }
}