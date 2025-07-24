class Solution {
  // Global state variables
  late List<List<int>> tree;
  late List<int> nums;
  late List<int> subtreeXor;
  late List<int> inTime;
  late List<int> outTime;
  int timer = 0;
  int totalXor = 0;
  int result = 1 << 30;

  int minimumScore(List<int> numsInput, List<List<int>> edges) {
    nums = numsInput;
    int n = nums.length;
    tree = List.generate(n, (_) => []);
    subtreeXor = List.filled(n, 0);
    inTime = List.filled(n, 0);
    outTime = List.filled(n, 0);

    // Build tree
    for (var edge in edges) {
      int u = edge[0], v = edge[1];
      tree[u].add(v);
      tree[v].add(u);
    }

    // Step 1: Precompute subtree XOR and Euler tour times
    void dfs(int node, int parent) {
      inTime[node] = timer++;
      int xorSum = nums[node];

      for (int neighbor in tree[node]) {
        if (neighbor == parent) continue;
        dfs(neighbor, node);
        xorSum ^= subtreeXor[neighbor];
      }

      subtreeXor[node] = xorSum;
      outTime[node] = timer++;
    }

    dfs(0, -1); // Start DFS at root
    totalXor = subtreeXor[0];

    // Step 2: Try every pair of non-root edges using parent-child pairs
    for (int i = 1; i < n; i++) {
      for (int j = 1; j < n; j++) {
        if (i == j) continue;

        // Determine which node is ancestor of which
        if (isAncestor(i, j)) {
          // i is ancestor of j
          int part1 = subtreeXor[j];
          int part2 = subtreeXor[i] ^ part1;
          int part3 = totalXor ^ subtreeXor[i];
          updateResult(part1, part2, part3);
        } else if (isAncestor(j, i)) {
          // j is ancestor of i
          int part1 = subtreeXor[i];
          int part2 = subtreeXor[j] ^ part1;
          int part3 = totalXor ^ subtreeXor[j];
          updateResult(part1, part2, part3);
        } else {
          // No ancestor relation — independent subtrees
          int part1 = subtreeXor[i];
          int part2 = subtreeXor[j];
          int part3 = totalXor ^ part1 ^ part2;
          updateResult(part1, part2, part3);
        }
      }
    }

    return result;
  }

  // Checks if u is ancestor of v using in/out time from Euler tour
  bool isAncestor(int u, int v) {
    return inTime[u] <= inTime[v] && outTime[v] <= outTime[u];
  }

  // Update the minimum score found so far
  void updateResult(int a, int b, int c) {
    int maxVal = [a, b, c].reduce((x, y) => x > y ? x : y);
    int minVal = [a, b, c].reduce((x, y) => x < y ? x : y);
    result = result < (maxVal - minVal) ? result : (maxVal - minVal);
  }
}
