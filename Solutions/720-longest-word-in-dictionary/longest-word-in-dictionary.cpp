class Solution {
public:
    string longestWord(vector<string>& words) {
        // Step 1: Sort words by length, then lexicographically
        sort(words.begin(), words.end(), [](const string &a, const string &b) {
            if (a.size() != b.size()) return a.size() < b.size();
            return a < b;
        });
        
        unordered_set<string> built;
        string result = "";
        
        // Step 2: Build words
        for (const string &word : words) {
            if (word.size() == 1 || built.count(word.substr(0, word.size() - 1))) {
                built.insert(word); // add to valid words
                
                // Update longest word
                if (word.size() > result.size() || (word.size() == result.size() && word < result)) {
                    result = word;
                }
            }
        }
        
        return result;
    }
};
