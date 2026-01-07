class Solution {
  List<int> beautifulArray(int n) {
    // Base case: if n == 1, the only array is [1], which is trivially beautiful
    if (n == 1) return [1];

    // Divide the problem into odd and even numbers
    // Recursively generate beautiful arrays for half size
    List<int> odd = beautifulArray((n + 1) ~/ 2); // ceil(n/2)
    List<int> even = beautifulArray(n ~/ 2);      // floor(n/2)

    // Initialize result array
    List<int> result = [];

    // Map odd-array values to actual odd numbers in range [1, n]
    for (int x in odd) {
      result.add(2 * x - 1); // Convert to odd numbers
    }

    // Map even-array values to actual even numbers in range [1, n]
    for (int x in even) {
      result.add(2 * x); // Convert to even numbers
    }

    // Return the combined beautiful array
    return result;
  }
}
