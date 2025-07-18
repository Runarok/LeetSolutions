import 'package:collection/collection.dart'; // Required for using PriorityQueue

class Solution {
  int minimumDifference(List<int> nums) {
    int n3 = nums.length; // Total length of nums = 3n
    int n = n3 ~/ 3;      // Each partition length = n

    // part1[i] stores the minimum sum of the first (i + n) elements from left after removing n largest elements
    List<int> part1 = List.filled(n + 1, 0);

    // Calculate sum of the first n elements
    int total = nums.sublist(0, n).reduce((a, b) => a + b);

    // Max heap to track and remove the largest elements from the left side
    PriorityQueue<int> ql = PriorityQueue<int>((a, b) => b.compareTo(a));
    for (int i = 0; i < n; i++) {
      ql.add(nums[i]);
    }

    part1[0] = total; // Store sum of first n elements

    // Process the middle n elements from index n to 2n-1
    for (int i = n; i < n * 2; i++) {
      total += nums[i];         // Add current element to total
      ql.add(nums[i]);          // Add to max heap
      total -= ql.removeFirst(); // Remove the largest element to maintain n smallest
      part1[i - (n - 1)] = total; // Store result for current partition
    }

    // Now, process the last n elements from the right side
    int part2 = nums.sublist(n * 2).reduce((a, b) => a + b); // Initial sum of last n elements

    // Min heap to track and remove the smallest elements from the right side
    PriorityQueue<int> qr = PriorityQueue<int>();
    for (int i = n * 2; i < n3; i++) {
      qr.add(nums[i]);
    }

    // Initialize answer with the difference between the first computed sums
    int ans = part1[n] - part2;

    // Traverse backward from index 2n-1 to n (middle section)
    for (int i = n * 2 - 1; i >= n; i--) {
      part2 += nums[i];         // Add current element
      qr.add(nums[i]);          // Add to min heap
      part2 -= qr.removeFirst(); // Remove smallest to maintain n largest
      // Update the answer with the minimum difference
      ans = ans < (part1[i - n] - part2) ? ans : (part1[i - n] - part2);
    }

    return ans; // Return the minimal difference
  }
}
