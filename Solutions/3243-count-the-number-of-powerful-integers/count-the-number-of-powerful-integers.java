public class Solution {

    // Recursive function to count powerful integers
    private long dfs(int i, boolean limitLow, boolean limitHigh, String low, String high, 
                     int limit, String s, int preLen, long[] memo, int n) {
        // Base case: when we have processed all the digits
        if (i == n) {
            return 1; // We've successfully formed a valid number
        }

        // If this state has been calculated before, return the stored result
        if (!limitLow && !limitHigh && memo[i] != -1) {
            return memo[i];
        }

        // Determine the valid range for the current digit
        int lo = limitLow ? low.charAt(i) - '0' : 0; // Lower bound for the current digit
        int hi = limitHigh ? high.charAt(i) - '0' : 9; // Upper bound for the current digit

        long res = 0; // Variable to store the result for this recursive state

        // Case where the current position is before the prefix length (preLen)
        if (i < preLen) {
            // Try all possible digits within the valid range [lo, min(hi, limit)]
            for (int digit = lo; digit <= Math.min(hi, limit); digit++) {
                res += dfs(i + 1, limitLow && (digit == low.charAt(i) - '0'),
                        limitHigh && (digit == high.charAt(i) - '0'), low, high, limit,
                        s, preLen, memo, n);
            }
        } else {
            // Case where the current position corresponds to a character in string `s`
            int x = s.charAt(i - preLen) - '0'; // Get the digit from string `s`
            // If this digit lies within the valid range, recurse further
            if (lo <= x && x <= Math.min(hi, limit)) {
                res = dfs(i + 1, limitLow && (x == low.charAt(i) - '0'),
                        limitHigh && (x == high.charAt(i) - '0'), low, high, limit, s,
                        preLen, memo, n);
            }
        }

        // Memoize the result if not in the limit-low and limit-high case
        if (!limitLow && !limitHigh) {
            memo[i] = res;
        }

        return res;
    }

    // Function to count the number of powerful integers in the range [start..finish]
    public long numberOfPowerfulInt(long start, long finish, int limit, String s) {
        // Convert start and finish to string
        String low = Long.toString(start);
        String high = Long.toString(finish);
        int n = high.length(); // Length of the high string (number of digits)

        // Pad the low string with leading zeros to match the length of the high string
        StringBuilder paddedLowBuilder = new StringBuilder();
        for (int i = 0; i < n - low.length(); i++) {
            paddedLowBuilder.append('0'); // Add leading zeros
        }
        paddedLowBuilder.append(low); // Append the low value
        String paddedLow = paddedLowBuilder.toString();

        // Calculate the prefix length (the number of digits before the suffix `s`)
        int preLen = n - s.length();

        // Initialize the memoization array with -1 (indicating uncalculated states)
        long[] memo = new long[n];
        for (int i = 0; i < n; i++) {
            memo[i] = -1;
        }

        // Call the recursive function to calculate the result
        return dfs(0, true, true, paddedLow, high, limit, s, preLen, memo, n);
    }

}
