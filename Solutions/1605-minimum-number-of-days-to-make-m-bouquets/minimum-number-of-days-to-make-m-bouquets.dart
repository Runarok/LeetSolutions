class Solution {
  /// Main function to find minimum days to make m bouquets
  int minDays(List<int> bloomDay, int m, int k) {
    int n = bloomDay.length;

    // If total flowers < total flowers needed for bouquets, impossible
    if (n < m * k) return -1;

    // Helper function: check if we can make m bouquets by "day"
    bool canMake(int day) {
      int bouquets = 0; // number of bouquets we can make
      int flowers = 0; // consecutive bloomed flowers

      for (int bloom in bloomDay) {
        if (bloom <= day) {
          // Flower bloomed, increase consecutive count
          flowers++;
          if (flowers == k) {
            // We can make a bouquet
            bouquets++;
            flowers = 0; // reset for next bouquet
          }
        } else {
          // Flower hasn't bloomed, reset consecutive count
          flowers = 0;
        }
      }
      return bouquets >= m; // True if we can make required bouquets
    }

    // Binary search boundaries
    int left = 1; // minimum possible day
    int right = 0; // maximum bloom day
    for (int day in bloomDay) {
      right = day > right ? day : right;
    }

    int result = -1;

    // Binary search to find smallest day we can make m bouquets
    while (left <= right) {
      int mid = left + (right - left) ~/ 2;
      if (canMake(mid)) {
        // If possible, try smaller days
        result = mid;
        right = mid - 1;
      } else {
        // Not possible, try bigger days
        left = mid + 1;
      }
    }

    return result;
  }
}
