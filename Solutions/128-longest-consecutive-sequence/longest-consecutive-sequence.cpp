class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        if (nums.empty()) return 0; // edge case

        // Step 1: put all numbers in a set for O(1) lookups
        unordered_set<int> numSet(nums.begin(), nums.end());

        int longestStreak = 0;

        // Step 2: iterate over each number
        for (int num : numSet) {
            // Only start counting if `num` is the beginning of a sequence
            if (numSet.find(num - 1) == numSet.end()) {
                int currentNum = num;
                int streak = 1;

                // Step 3: extend the streak
                while (numSet.find(currentNum + 1) != numSet.end()) {
                    currentNum += 1;
                    streak += 1;
                }

                // Step 4: update the longest streak
                longestStreak = max(longestStreak, streak);
            }
        }

        return longestStreak;
    }
};
