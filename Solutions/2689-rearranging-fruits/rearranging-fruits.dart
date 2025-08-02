import 'dart:collection'; // Needed for SplayTreeMap (sorted map)

class Solution {
  int minCost(List<int> basket1, List<int> basket2) {
    // freq will track the net difference of each fruit between the baskets
    var freq = SplayTreeMap<int, int>();

    // Track the minimum fruit value seen in both baskets
    int m = basket1.fold(1 << 31, (minVal, val) => val < minVal ? val : minVal);

    // Step 1: Add +1 for each fruit in basket1
    for (var b1 in basket1) {
      freq[b1] = (freq[b1] ?? 0) + 1;
      m = b1 < m ? b1 : m; // update global minimum
    }

    // Step 2: Subtract -1 for each fruit in basket2
    for (var b2 in basket2) {
      freq[b2] = (freq[b2] ?? 0) - 1;
      m = b2 < m ? b2 : m; // update global minimum
    }

    // List to collect fruits that need to be swapped
    List<int> merge = [];

    // Step 3: Analyze net fruit differences
    for (var entry in freq.entries) {
      int count = entry.value;

      // If any fruit has an odd imbalance, it's impossible to balance the baskets
      if (count % 2 != 0) return -1;

      // For each surplus/deficit, add half the imbalance to merge list
      for (int i = 0; i < (count.abs() ~/ 2); i++) {
        merge.add(entry.key);
      }
    }

    // Step 4: Sort merge list to process cheapest swaps first
    merge.sort();

    int res = 0;
    int n = merge.length;

    // Step 5: Only half the merge list needs to be swapped (rest are mirror swaps)
    for (int i = 0; i < n ~/ 2; i++) {
      // Choose the cheaper option between direct swap and double swap using min element
      res += merge[i] < 2 * m ? merge[i] : 2 * m;
    }

    return res;
  }
}
