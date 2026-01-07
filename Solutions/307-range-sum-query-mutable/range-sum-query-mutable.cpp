class NumArray {
private:
    vector<int> BIT;   // Fenwick Tree
    vector<int> nums;  // Original array
    int n;
    
    // ------------------------------------
    // Add value to Fenwick Tree at index i
    // ------------------------------------
    void add(int i, int delta) {
        // Fenwick Tree is 1-indexed
        i++;
        while (i <= n) {
            BIT[i] += delta;
            // Move to next responsible index
            i += (i & -i);
        }
    }
    
    // ------------------------------------
    // Get prefix sum from index 0 to i
    // ------------------------------------
    int prefixSum(int i) {
        int sum = 0;
        i++;
        while (i > 0) {
            sum += BIT[i];
            // Move to parent index
            i -= (i & -i);
        }
        return sum;
    }

public:
    // -------------------------------
    // Constructor
    // -------------------------------
    NumArray(vector<int>& nums) {
        this->nums = nums;
        n = nums.size();
        
        // Fenwick Tree size = n + 1 (1-indexed)
        BIT.assign(n + 1, 0);
        
        // Build Fenwick Tree
        for (int i = 0; i < n; i++) {
            add(i, nums[i]);
        }
    }
    
    // -------------------------------
    // Update nums[index] to val
    // -------------------------------
    void update(int index, int val) {
        // Difference between new value and old value
        int delta = val - nums[index];
        
        // Update original array
        nums[index] = val;
        
        // Update Fenwick Tree
        add(index, delta);
    }
    
    // -------------------------------
    // Return sum in range [left, right]
    // -------------------------------
    int sumRange(int left, int right) {
        // Range sum = prefixSum(right) - prefixSum(left - 1)
        return prefixSum(right) - prefixSum(left - 1);
    }
};


/**
 * Your NumArray object will be instantiated and called as such:
 * NumArray* obj = new NumArray(nums);
 * obj->update(index,val);
 * int param_2 = obj->sumRange(left,right);
 */