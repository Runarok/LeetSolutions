class Solution {
  // Function to find the minimum operations to make all elements equal to `k`
  int minOperations(List<int> nums, int k) {
    // Set to keep track of distinct elements greater than `k`
    Set<int> st = {};
    
    // Iterate through each element in the `nums` list
    for (int x in nums) {
      // If the element is less than `k`, return -1 because it's impossible to make all elements equal to `k`
      if (x < k) {
        return -1;
      } 
      // If the element is greater than `k`, add it to the set to track distinct values that need to be reduced
      else if (x > k) {
        st.add(x);
      }
    }
    
    // Return the number of distinct values in `st` that are greater than `k`
    return st.length;
  }
}
