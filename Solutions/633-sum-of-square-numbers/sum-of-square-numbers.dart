import 'dart:math';

class Solution {
  bool judgeSquareSum(int c) {
    // Initialize two pointers
    int a = 0;
    int b = sqrt(c).toInt(); // maximum possible value for b

    // Loop until a exceeds b
    while (a <= b) {
      int sum = a * a + b * b; // current sum of squares

      if (sum == c) {
        return true; // Found integers a and b
      } else if (sum < c) {
        a++; // Increase a to get a larger sum
      } else {
        b--; // Decrease b to get a smaller sum
      }
    }

    // No such integers found
    return false;
  }
}
