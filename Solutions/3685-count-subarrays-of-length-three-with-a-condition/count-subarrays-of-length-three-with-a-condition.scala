object Solution {
  def countSubarrays(nums: Array[Int]): Int = {
    // Length of the input array
    val n = nums.length
    
    // Variable to keep track of the number of valid subarrays
    var ans = 0
    
    // Loop through the array from index 1 to n-2 (since we need triplets)
    for (i <- 1 until n - 1) {
      
      // Check if the sum of the first and third elements is twice the middle element
      if (nums(i) == (nums(i - 1) + nums(i + 1)) * 2) {
        // If condition is satisfied, increment the answer counter
        ans += 1
      }
    }
    
    // Return the total number of valid subarrays
    ans
  }
}
