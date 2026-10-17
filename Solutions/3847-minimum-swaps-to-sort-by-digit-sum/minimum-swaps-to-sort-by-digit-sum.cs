using System;
using System.Collections.Generic;
using System.Linq;

public class Solution {
    public int MinSwaps(int[] nums) {
        int n = nums.Length;
        
        // Step 1: Create an array of tuples or a custom structure to store:
        // - The number itself
        // - Its original index
        // - Its digit sum
        var items = new (int value, int originalIndex, int digitSum)[n];
        for (int i = 0; i < n; i++) {
            items[i] = (nums[i], i, GetDigitSum(nums[i]));
        }
        
        // Step 2: Sort the array based on our custom criteria:
        // 1. Primary: Digit sum ascending
        // 2. Secondary: Value ascending (since nums consists of distinct positive integers)
        Array.Sort(items, (a, b) => {
            if (a.digitSum != b.digitSum) {
                return a.digitSum.CompareTo(b.digitSum);
            }
            return a.value.CompareTo(b.value);
        });
        
        // Step 3: Find the minimum swaps required using cycle decomposition (disjoint sets / cycles)
        bool[] visited = new bool[n];
        int swaps = 0;
        
        for (int i = 0; i < n; i++) {
            // If the element is already visited or already in its correct sorted position
            if (visited[i] || items[i].originalIndex == i) {
                continue;
            }
            
            // Traverse the cycle
            int cycleSize = 0;
            int curr = i;
            
            while (!visited[curr]) {
                visited[curr] = true;
                // Move to the index where the original element currently resides
                curr = items[curr].originalIndex;
                cycleSize++;
            }
            
            // If cycle size is greater than 1, it contributes (cycleSize - 1) swaps
            if (cycleSize > 1) {
                swaps += (cycleSize - 1);
            }
        }
        
        return swaps;
    }
    
    // Helper function to calculate the sum of digits of a number
    private int GetDigitSum(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}