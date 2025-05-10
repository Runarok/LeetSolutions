func minSum(nums1 []int, nums2 []int) int64 {
    var sum1, sum2 int64  // Initialize variables to store the sum of nums1 and nums2
    var zero1, zero2 int   // Initialize counters to track the number of zeroes in nums1 and nums2

    // Loop through nums1 to calculate its sum and count the zeroes
    for _, num := range nums1 {
        sum1 += int64(num)  // Add the non-zero value of num to sum1
        if num == 0 {
            sum1++  // If num is 0, increment sum1 (since we'll replace 0 with a positive integer)
            zero1++  // Count the zeroes in nums1
        }
    }

    // Loop through nums2 to calculate its sum and count the zeroes
    for _, num := range nums2 {
        sum2 += int64(num)  // Add the non-zero value of num to sum2
        if num == 0 {
            sum2++  // If num is 0, increment sum2 (since we'll replace 0 with a positive integer)
            zero2++  // Count the zeroes in nums2
        }
    }

    // Check if it's impossible to balance the sums when no zeroes are present
    // If one array's sum is strictly greater than the other and no zeroes exist, return -1
    if (zero1 == 0 && sum2 > sum1) || (zero2 == 0 && sum1 > sum2) {
        return -1  // If there's no way to adjust the sums using zeroes, return -1
    }

    // If sum1 is greater than sum2, return sum1 (since we want the higher sum in case of imbalance)
    if sum1 > sum2 {
        return sum1
    }
    
    // If sum2 is greater than sum1, return sum2
    return sum2
}
