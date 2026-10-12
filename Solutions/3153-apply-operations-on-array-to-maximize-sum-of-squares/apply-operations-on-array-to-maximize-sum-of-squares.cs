using System;
using System.Collections.Generic;

public class Solution {
    public int MaxSum(IList<int> nums, int k) {
        int[] bitCount = new int[32];
        
        // Count the number of set bits at each position across all elements
        foreach (int num in nums) {
            for (int i = 0; i < 32; i++) {
                if ((num & (1 << i)) != 0) {
                    bitCount[i]++;
                }
            }
        }
        
        long[] maxNums = new long[k];
        
        // Greedily place the bits from the most significant bit to the least
        for (int i = 31; i >= 0; i--) {
            int count = bitCount[i];
            for (int j = 0; j < k && count > 0; j++) {
                maxNums[j] |= (1L << i);
                count--;
            }
        }
        
        long mod = 1000000007;
        long totalSum = 0;
        
        foreach (long num in maxNums) {
            totalSum = (totalSum + (num * num) % mod) % mod;
        }
        
        return (int)totalSum;
    }
}