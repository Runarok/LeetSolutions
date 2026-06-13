class Solution {
public:
    string mapWordWeights(vector<string>& words, vector<int>& weights) {
        // String to store the final answer
        string result = "";

        // Process each word one by one
        for (string &word : words) {

            // Calculate the total weight of the current word
            int totalWeight = 0;

            // Add the weight of every character in the word
            for (char ch : word) {
                // Convert character to index:
                // 'a' -> 0, 'b' -> 1, ..., 'z' -> 25
                int idx = ch - 'a';

                // Add corresponding character weight
                totalWeight += weights[idx];
            }

            // Take modulo 26 as required
            int modValue = totalWeight % 26;

            // Reverse alphabetical mapping:
            // 0 -> 'z'
            // 1 -> 'y'
            // ...
            // 25 -> 'a'
            char mappedChar = 'z' - modValue;

            // Append mapped character to answer
            result += mappedChar;
        }

        // Return the concatenated string
        return result;
    }
};