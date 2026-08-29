class Solution {
    public String lexPalindromicPermutation(String s, String target) {
        int n = s.length();

        // Special case: a single character can only form itself.
        if (n == 1) {
            return s.compareTo(target) > 0 ? s : "";
        }

        // Count the frequency of each character.
        int[] cnt = new int[26];

        for (char c : s.toCharArray()) {
            cnt[c - 'a']++;
        }

        // A palindrome can have at most one character
        // with an odd frequency.
        String oddChar = "";

        for (int i = 0; i < 26; i++) {
            if (cnt[i] % 2 == 1) {
                // More than one odd-frequency character
                // means no palindrome can be formed.
                if (!oddChar.isEmpty()) {
                    return "";
                }

                oddChar = String.valueOf((char) ('a' + i));
            }

            // We only need half of each frequency
            // to construct the left half of the palindrome.
            cnt[i] /= 2;
        }

        StringBuilder prefix = new StringBuilder();

        // Build the left half greedily.
        for (int i = 0; i < n / 2; i++) {
            boolean found = false;

            // Try the smallest possible character first.
            for (int j = 0; j < 26; j++) {
                if (cnt[j] == 0) {
                    continue;
                }

                // Temporarily use this character.
                cnt[j]--;

                // Check whether this choice can produce
                // a palindrome greater than target.
                if (canMakeGreater(prefix, (char) ('a' + j),
                                   cnt, oddChar, target)) {

                    // This is the smallest valid character
                    // for the current position.
                    prefix.append((char) ('a' + j));
                    found = true;
                    break;
                }

                // This choice does not work, so restore it.
                cnt[j]++;
            }

            // No character can be placed at this position.
            if (!found) {
                return "";
            }

            // If the prefix is already greater than target,
            // fill the remaining characters in ascending order
            // to get the smallest possible answer.
            if (prefix.charAt(i) > target.charAt(i)) {
                StringBuilder left = new StringBuilder(prefix);

                for (int j = 0; j < 26; j++) {
                    while (cnt[j] > 0) {
                        left.append((char) ('a' + j));
                        cnt[j]--;
                    }
                }

                return buildPalindrome(left.toString(), oddChar);
            }
        }

        // Construct the final palindrome.
        return buildPalindrome(prefix.toString(), oddChar);
    }

    // Checks whether choosing 'c' as the next character
    // can lead to a palindrome greater than target.
    private boolean canMakeGreater(
            StringBuilder prefix,
            char c,
            int[] cnt,
            String oddChar,
            String target) {

        StringBuilder left = new StringBuilder(prefix);
        left.append(c);

        // To maximize the palindrome for this prefix,
        // put the remaining characters in descending order.
        for (int i = 25; i >= 0; i--) {
            for (int j = 0; j < cnt[i]; j++) {
                left.append((char) ('a' + i));
            }
        }

        // Construct the complete palindrome.
        String palindrome = buildPalindrome(left.toString(), oddChar);

        return palindrome.compareTo(target) > 0;
    }

    // Builds a palindrome from the left half and middle character.
    private String buildPalindrome(String left, String oddChar) {
        StringBuilder result = new StringBuilder();

        // Add the left half.
        result.append(left);

        // Add the middle character, if one exists.
        result.append(oddChar);

        // Add the reversed left half.
        result.append(new StringBuilder(left).reverse());

        return result.toString();
    }
}
