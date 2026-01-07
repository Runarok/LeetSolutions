class Solution {
public:
    int maxSatisfied(vector<int>& customers, vector<int>& grumpy, int minutes) {
        int n = customers.size();
        int alwaysSatisfied = 0; // sum of customers when owner is not grumpy
        
        // Step 1: calculate always satisfied customers
        for (int i = 0; i < n; i++) {
            if (grumpy[i] == 0)
                alwaysSatisfied += customers[i];
        }
        
        // Step 2: sliding window to find max extra satisfied customers
        int extraSatisfied = 0;    // current window sum
        int maxExtraSatisfied = 0; // maximum over all windows
        
        // initialize first window
        for (int i = 0; i < minutes; i++) {
            if (grumpy[i] == 1)
                extraSatisfied += customers[i];
        }
        maxExtraSatisfied = extraSatisfied;
        
        // slide the window
        for (int i = minutes; i < n; i++) {
            // add new entering element if grumpy
            if (grumpy[i] == 1)
                extraSatisfied += customers[i];
            // remove element leaving window if grumpy
            if (grumpy[i - minutes] == 1)
                extraSatisfied -= customers[i - minutes];
            // update maximum
            maxExtraSatisfied = max(maxExtraSatisfied, extraSatisfied);
        }
        
        // Step 3: total maximum satisfied
        return alwaysSatisfied + maxExtraSatisfied;
    }
};
