class Solution {
  int possibleStringCount(String word, int k) {
    const int MOD = 1000000007;

    int n = word.length;
    if (n == 0) return 0;

    // Step 1: Compute frequencies of consecutive characters (run lengths)
    List<int> freq = [];
    int count = 1;

    for (int i = 1; i < n; i++) {
      if (word[i] == word[i - 1]) {
        count++;
      } else {
        freq.add(count);
        count = 1;
      }
    }
    freq.add(count); // add last count

    // Step 2: Compute the total combinations without restriction
    int ans = 1;
    for (int f in freq) {
      ans = (ans * f) % MOD;
    }

    // If we already have at least k runs, return the answer
    if (freq.length >= k) {
      return ans;
    }

    int m = k;
    List<int> f = List.filled(m, 0); // DP: f[i] = #ways using exactly i groups
    List<int> g = List.filled(m, 1); // Prefix sums of f, for efficient range sum
    f[0] = 1;

    for (int num in freq) {
      List<int> fNew = List.filled(m, 0);
      for (int j = 1; j < m; j++) {
        fNew[j] = g[j - 1];
        if (j - num - 1 >= 0) {
          fNew[j] = (fNew[j] - g[j - num - 1] + MOD) % MOD;
        }
      }

      // Update prefix sums for new f
      List<int> gNew = List.filled(m, 0);
      gNew[0] = fNew[0];
      for (int j = 1; j < m; j++) {
        gNew[j] = (gNew[j - 1] + fNew[j]) % MOD;
      }

      f = fNew;
      g = gNew;
    }

    // Subtract invalid cases (with fewer than k groups) from total
    return ((ans - g[m - 1] + MOD) % MOD);
  }
}
