class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        if (strs.empty()) return ""; // edge case
        
        // Start with the first string as the prefix
        string prefix = strs[0];
        
        // Compare prefix with each string
        for (int i = 1; i < strs.size(); i++) {
            string &s = strs[i];
            
            // Shorten the prefix until it matches the start of s
            while (s.find(prefix) != 0) {
                prefix = prefix.substr(0, prefix.size() - 1);
                
                // No common prefix
                if (prefix.empty()) return "";
            }
        }
        
        return prefix;
    }
};
