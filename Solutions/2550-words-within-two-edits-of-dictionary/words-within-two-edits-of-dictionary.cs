public class Solution {
    public IList<string> TwoEditWords(string[] queries, string[] dictionary) {
        // This will store the final result
        List<string> result = new List<string>();

        // Loop through each query word
        foreach (string query in queries) {

            // Flag to check if current query matches any dictionary word
            bool isValid = false;

            // Compare this query with every word in dictionary
            foreach (string word in dictionary) {

                // Count how many characters are different
                int diffCount = 0;

                // Compare character by character
                for (int i = 0; i < query.Length; i++) {

                    // If characters differ, increment counter
                    if (query[i] != word[i]) {
                        diffCount++;

                        // Optimization: if already more than 2 edits, stop early
                        if (diffCount > 2) {
                            break;
                        }
                    }
                }

                // If difference is 2 or less, this query is valid
                if (diffCount <= 2) {
                    isValid = true;
                    break; // No need to check other dictionary words
                }
            }

            // If we found a match, add to result
            if (isValid) {
                result.Add(query);
            }
        }

        // Return final list
        return result;
    }
}