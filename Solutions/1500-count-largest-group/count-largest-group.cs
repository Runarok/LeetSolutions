public class Solution {
    public int CountLargestGroup(int n) {
        // Dictionary to store the frequency of each digit sum
        var hashMap = new Dictionary<int, int>();
        int maxValue = 0; // To keep track of the maximum group size

        // Iterate through all numbers from 1 to n
        for (int i = 1; i <= n; ++i) {
            int key = 0;
            int i0 = i;

            // Compute the sum of the digits of the number i
            while (i0 > 0) {
                key += i0 % 10; // Add the last digit to the key
                i0 /= 10;       // Remove the last digit
            }

            // Update the count of numbers with the same digit sum in the dictionary
            if (hashMap.ContainsKey(key)) {
                hashMap[key]++;
            } else {
                hashMap[key] = 1;
            }

            // Keep track of the largest group size seen so far
            maxValue = Math.Max(maxValue, hashMap[key]);
        }

        int count = 0;

        // Count how many groups have the maximum size
        foreach (var value in hashMap.Values) {
            if (value == maxValue) {
                count++;
            }
        }

        return count; // Return the number of largest groups
    }
}