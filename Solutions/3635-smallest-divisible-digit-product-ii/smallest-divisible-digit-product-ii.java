class Solution {

    public String smallestNumber(String num, long t) {

        // ------------------------------------------------------------
        // Step 1:
        // Check whether t contains any prime factor greater than 9.
        //
        // Since every digit is between 1 and 9, the product of digits
        // can only be made from prime factors:
        // 2, 3, 5 and 7.
        //
        // We divide t by every digit from 2 to 9 as much as possible.
        // If anything remains, then t has some prime factor > 7,
        // making the answer impossible.
        // ------------------------------------------------------------
        long temp = t;

        for (int i = 2; i <= 9; i++) {

            while (temp % i == 0) {
                temp /= i;
            }
        }

        // Impossible to create such a product.
        if (temp > 1) {
            return "-1";
        }

        int n = num.length();

        // ------------------------------------------------------------
        // rem[i]
        //
        // rem[i] = remaining divisor after processing the first i digits.
        //
        // Example:
        // num = "236"
        // t = 72
        //
        // rem[0] = 72
        //
        // digit 2
        // gcd(72,2)=2
        // rem[1]=36
        //
        // digit 3
        // gcd(36,3)=3
        // rem[2]=12
        //
        // digit 6
        // gcd(12,6)=6
        // rem[3]=2
        //
        // rem[n]==1 means the original number already works.
        // ------------------------------------------------------------
        long[] rem = new long[n + 1];

        rem[0] = t;

        // ------------------------------------------------------------
        // pos stores the first position that must be modified.
        //
        // If the number contains a zero, we cannot keep it because
        // the answer must be zero-free.
        //
        // Therefore, once we see the first zero,
        // we stop processing prefixes.
        // ------------------------------------------------------------
        int pos = n - 1;

        char[] numChars = num.toCharArray();

        for (int i = 0; i < n; i++) {

            // Zero is not allowed.
            if (numChars[i] == '0') {
                pos = i;
                break;
            }

            // Remove common factors contributed by this digit.
            rem[i + 1] = rem[i] / gcd(rem[i], numChars[i] - '0');
        }

        // ------------------------------------------------------------
        // If rem[n] becomes 1,
        // every required factor has already been supplied.
        // ------------------------------------------------------------
        if (rem[n] == 1) {
            return num;
        }

        // ------------------------------------------------------------
        // Step 2
        //
        // Try increasing digits from right to left.
        //
        // This is exactly like finding the next lexicographically
        // larger number.
        // ------------------------------------------------------------
        for (int i = pos; i >= 0; i--) {

            // Increase current digit.
            while (++numChars[i] <= '9') {

                // ----------------------------------------------------
                // Remaining divisor after fixing this digit.
                //
                // We remove whatever factors this new digit provides.
                // ----------------------------------------------------
                long tNow = rem[i] / gcd(rem[i], numChars[i] - '0');

                // ----------------------------------------------------
                // Fill the suffix greedily.
                //
                // Always try placing the largest possible digit
                // because it contributes the most factors,
                // allowing earlier digits to stay smaller.
                // ----------------------------------------------------
                int k = 9;

                for (int j = n - 1; j > i; j--) {

                    // Find largest digit dividing remaining value.
                    while (tNow % k != 0) {
                        k--;
                    }

                    // Consume factors.
                    tNow /= k;

                    // Place chosen digit.
                    numChars[j] = (char) ('0' + k);
                }

                // Entire divisor satisfied.
                if (tNow == 1) {
                    return new String(numChars);
                }
            }
        }

        // ------------------------------------------------------------
        // Step 3
        //
        // No answer of the same length exists.
        //
        // Build the smallest longer answer.
        // ------------------------------------------------------------
        StringBuilder ans = new StringBuilder();

        long originalT = t;

        // ------------------------------------------------------------
        // Factorize using largest digits first.
        //
        // Example:
        //
        // t = 72
        //
        // divide by 9
        // divide by 8
        // divide by 2
        //
        // digits collected:
        // 9 8
        //
        // Reverse later to make smallest number.
        // ------------------------------------------------------------
        for (int i = 9; i > 1; i--) {

            while (originalT % i == 0) {

                ans.append((char) ('0' + i));

                originalT /= i;
            }
        }

        // ------------------------------------------------------------
        // If the constructed number is shorter than n+1,
        // pad with leading ones.
        //
        // Ones don't affect the product.
        // ------------------------------------------------------------
        int padding = Math.max(n + 1 - ans.length(), 0);

        for (int i = 0; i < padding; i++) {
            ans.append('1');
        }

        // Digits were collected largest first.
        // Reverse to obtain the smallest number.
        return ans.reverse().toString();
    }

    // ------------------------------------------------------------
    // Standard Euclidean Algorithm.
    //
    // Returns greatest common divisor of a and b.
    //
    // Used to remove from t only the factors supplied by a digit.
    // ------------------------------------------------------------
    private long gcd(long a, long b) {

        while (b != 0) {

            long temp = b;

            b = a % b;

            a = temp;
        }

        return a;
    }
}