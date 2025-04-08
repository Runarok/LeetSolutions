class Solution {
  int minimumOperations(List<int> nums) {
    // Variable to count the number of operations needed
    int operations = 0;
    
    // Loop continues until the array has all distinct elements or is empty
    while (true) {
      // Check if the current array has all distinct elements
      if (nums.toSet().length == nums.length) {
        break; // If all elements are distinct, exit the loop
      }
      
      // Remove the first 3 elements from the list
      // If the list has fewer than 3 elements, remove all of them
      int removeCount = nums.length >= 3 ? 3 : nums.length;
      nums = nums.sublist(removeCount);
      
      // Increment the operation count as we've performed one removal
      operations++;
      
      // If the array becomes empty after removal, we can exit the loop
      if (nums.isEmpty) {
        break;
      }
    }
    
    // Return the total number of operations performed
    return operations;
  }
}
