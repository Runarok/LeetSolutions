class Solution {
  int findLucky(List<int> arr) {
    // Create a map to store the frequency of each number in the array
    Map<int, int> freq = {};

    // Iterate through the array and populate the frequency map
    for (int num in arr) {
      // If the number is already in the map, increment its count
      // Otherwise, initialize it to 1
      freq[num] = (freq[num] ?? 0) + 1;
    }

    // Variable to track the maximum lucky number found
    int maxLucky = -1;

    // Iterate through the map entries
    for (var entry in freq.entries) {
      // Check if the number is equal to its frequency
      if (entry.key == entry.value) {
        // If it's lucky and greater than current maxLucky, update maxLucky
        if (entry.key > maxLucky) {
          maxLucky = entry.key;
        }
      }
    }

    // Return the largest lucky number found, or -1 if none were found
    return maxLucky;
  }
}
