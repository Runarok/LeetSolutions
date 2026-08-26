public class Solution {
    public string ShortestBeautifulSubstring(string s, int k) {
        int n = s.Length;

        // 'left' and 'right' represent the current sliding window.
        // We maintain the window so that it contains at most k ones.
        int left = 0;
        int ones = 0;

        // The best answer found so far.
        string answer = "";

        // The minimum length of a beautiful substring found so far.
        int minLength = int.MaxValue;

        for (int right = 0; right < n; right++) {

            // Add the current character to our window.
            if (s[right] == '1') {
                ones++;
            }

            // If there are more than k ones, move the left side
            // forward until there are at most k ones again.
            while (ones > k) {
                if (s[left] == '1') {
                    ones--;
                }

                left++;
            }

            // If the current window contains exactly k ones,
            // it is a beautiful substring.
            if (ones == k) {

                // Try to make the window as short as possible.
                //
                // Removing leading zeroes does not change the number
                // of ones, so we can safely move 'left' forward while
                // the first character is zero.
                while (left <= right && s[left] == '0') {
                    left++;
                }

                int currentLength = right - left + 1;

                // We found a shorter beautiful substring.
                if (currentLength < minLength) {
                    minLength = currentLength;
                    answer = s.Substring(left, currentLength);
                }
                // Same length: choose the lexicographically smaller one.
                else if (currentLength == minLength) {
                    string current = s.Substring(left, currentLength);

                    if (string.CompareOrdinal(current, answer) < 0) {
                        answer = current;
                    }
                }
            }
        }

        // If no substring with exactly k ones was found,
        // return the empty string.
        return answer;
    }
}
