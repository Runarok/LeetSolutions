public class Solution
{
    public string LexGreaterPermutation(string s, string target)
    {
        int n = s.Length;

        // Count the characters available in s.
        int[] count = new int[26];

        foreach (char c in s)
        {
            count[c - 'a']++;
        }

        // This will store the best answer found so far.
        //
        // We update it every time we are able to make the
        // string strictly greater at the current position.
        //
        // Because we process from left to right, a later
        // position where we increase the character gives us
        // a smaller lexicographical result.
        string answer = "";

        // Try to match target from left to right.
        for (int i = 0; i < n; i++)
        {
            int targetChar = target[i] - 'a';

            // Before consuming target[i], check whether we can
            // replace it with a character that is just slightly
            // larger.
            //
            // We want the smallest available character greater
            // than target[i].
            for (int c = targetChar + 1; c < 26; c++)
            {
                if (count[c] == 0)
                    continue;

                // We can make the answer strictly greater here.
                //
                // The prefix target[0..i-1] stays unchanged.
                StringBuilder candidate = new StringBuilder(n);

                // Add the prefix that is identical to target.
                for (int j = 0; j < i; j++)
                {
                    candidate.Append(target[j]);
                }

                // Use the smallest character greater than target[i].
                candidate.Append((char)('a' + c));

                // Remove the character we just used.
                count[c]--;

                // Put all remaining characters in sorted order.
                //
                // This produces the smallest possible suffix.
                for (int letter = 0; letter < 26; letter++)
                {
                    for (int k = 0; k < count[letter]; k++)
                    {
                        candidate.Append((char)('a' + letter));
                    }
                }

                // Restore the character because we are only
                // testing this possibility.
                count[c]++;

                // Save this candidate.
                //
                // We DON'T return immediately.
                //
                // A later position may allow us to create an even
                // smaller lexicographical answer.
                answer = candidate.ToString();

                // Since c is the smallest character greater than
                // target[i], there is no need to try larger c's.
                break;
            }

            // Now try to keep this position exactly equal to target[i].
            //
            // This is important: keeping the prefix equal for longer
            // is what makes the final answer lexicographically smaller.
            if (count[targetChar] == 0)
            {
                // We cannot continue matching target.
                //
                // The best candidate we found at an earlier position
                // is the answer.
                return answer;
            }

            // Consume target[i] and continue to the next position.
            count[targetChar]--;
        }

        // If we matched the entire target, then target itself is
        // a permutation of s.
        //
        // There is no permutation strictly greater than it.
        return answer;
    }
}
