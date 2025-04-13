public class Solution {
    public long CountGoodIntegers(int n, int k) {
        var dict = new HashSet<string>();

        // Calculate the starting number for half of the palindrome (excluding mirrored half)
        int baseVal = (int)Math.Pow(10, (n - 1) / 2);
        int skip = n & 1; // If n is odd, we skip the middle digit when mirroring

        // Generate all n-digit palindromic numbers
        for (int i = baseVal; i < baseVal * 10; i++) {
            string s = i.ToString();
            // Mirror the number to make it a full palindrome
            s += new string(s.Reverse().Skip(skip).ToArray());
            long palindromicInteger = long.Parse(s);

            // Check if the palindromic number is divisible by k
            if (palindromicInteger % k == 0) {
                // Sort the digits to track digit permutations (ignoring order)
                char[] chars = s.ToCharArray();
                Array.Sort(chars);
                dict.Add(new string(chars));
            }
        }

        // Precompute factorials for permutation calculations
        long[] factorial = new long[n + 1];
        factorial[0] = 1;
        for (int i = 1; i <= n; i++) {
            factorial[i] = factorial[i - 1] * i;
        }

        long ans = 0;
        foreach (string s in dict) {
            int[] cnt = new int[10]; // Count of each digit from 0 to 9

            foreach (char c in s) {
                cnt[c - '0']++;
            }

            // Calculate total number of unique permutations of the digits,
            // ensuring that the first digit is not zero (no leading zeros)
            long tot = (n - cnt[0]) * factorial[n - 1];

            // Divide by factorial of counts to avoid overcounting duplicates
            foreach (int x in cnt) {
                tot /= factorial[x];
            }

            ans += tot;
        }

        return ans;
    }
}