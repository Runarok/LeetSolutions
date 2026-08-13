class Solution {
  List<int> longestRepeating(
      String s, String queryCharacters, List<int> queryIndices) {
    final int n = s.length;
    final int k = queryCharacters.length;

    // ------------------------------------------------------------
    // Segment Tree Information
    //
    // For every segment tree node we store:
    //
    // leftChar:
    //     The character at the leftmost position of this segment.
    //
    // rightChar:
    //     The character at the rightmost position of this segment.
    //
    // leftRun:
    //     Length of the longest repeating-character sequence
    //     starting from the left side of this segment.
    //
    // rightRun:
    //     Length of the longest repeating-character sequence
    //     ending at the right side of this segment.
    //
    // best:
    //     Longest repeating-character substring anywhere inside
    //     this segment.
    // ------------------------------------------------------------

    final List<int> leftChar = List<int>.filled(4 * n, 0);
    final List<int> rightChar = List<int>.filled(4 * n, 0);

    final List<int> leftRun = List<int>.filled(4 * n, 0);
    final List<int> rightRun = List<int>.filled(4 * n, 0);

    final List<int> best = List<int>.filled(4 * n, 0);

    // Convert the string into character codes.
    final List<int> chars = List<int>.generate(
      n,
      (i) => s.codeUnitAt(i),
    );

    // ------------------------------------------------------------
    // pull()
    //
    // Combines the information of the two children and stores
    // the result in the parent node.
    //
    //       [ LEFT ] [ RIGHT ]
    //              |
    //           [ PARENT ]
    // ------------------------------------------------------------
    void pull(int node, int l, int r) {
      final int leftNode = node * 2;
      final int rightNode = node * 2 + 1;

      // The first character of the parent is the first character
      // of its left child.
      leftChar[node] = leftChar[leftNode];

      // The last character of the parent is the last character
      // of its right child.
      rightChar[node] = rightChar[rightNode];

      // Initially, the best answer is simply the best answer
      // from either child.
      best[node] = best[leftNode] > best[rightNode]
          ? best[leftNode]
          : best[rightNode];

      // Find the size of the left and right children.
      final int mid = (l + r) ~/ 2;
      final int leftLength = mid - l + 1;
      final int rightLength = r - mid;

      // ----------------------------------------------------------
      // Check whether a repeating sequence crosses the boundary.
      //
      // Example:
      //
      // LEFT  = "bbb"
      // RIGHT = "bbcc"
      //
      // The answer crossing the boundary is "bbbbb" = 5.
      // ----------------------------------------------------------
      if (rightChar[leftNode] == leftChar[rightNode]) {
        final int crossing =
            rightRun[leftNode] + leftRun[rightNode];

        if (crossing > best[node]) {
          best[node] = crossing;
        }
      }

      // ----------------------------------------------------------
      // Calculate leftRun.
      //
      // Normally the longest prefix belongs entirely to the
      // left child.
      //
      // But if the ENTIRE left child consists of the same
      // character, and that character matches the beginning
      // of the right child, the prefix can continue into
      // the right child.
      // ----------------------------------------------------------
      leftRun[node] = leftRun[leftNode];

      if (leftRun[leftNode] == leftLength &&
          rightChar[leftNode] == leftChar[rightNode]) {
        leftRun[node] =
            leftLength + leftRun[rightNode];
      }

      // ----------------------------------------------------------
      // Calculate rightRun.
      //
      // Same idea as leftRun, but starting from the right side.
      // ----------------------------------------------------------
      rightRun[node] = rightRun[rightNode];

      if (rightRun[rightNode] == rightLength &&
          rightChar[leftNode] == leftChar[rightNode]) {
        rightRun[node] =
            rightLength + rightRun[leftNode];
      }
    }

    // ------------------------------------------------------------
    // build()
    //
    // Builds the segment tree from the original string.
    // ------------------------------------------------------------
    void build(int node, int l, int r) {
      // Leaf node represents exactly one character.
      if (l == r) {
        leftChar[node] = chars[l];
        rightChar[node] = chars[l];

        leftRun[node] = 1;
        rightRun[node] = 1;
        best[node] = 1;

        return;
      }

      final int mid = (l + r) ~/ 2;

      // Build the left half.
      build(
        node * 2,
        l,
        mid,
      );

      // Build the right half.
      build(
        node * 2 + 1,
        mid + 1,
        r,
      );

      // Combine both children.
      pull(node, l, r);
    }

    // ------------------------------------------------------------
    // update()
    //
    // Changes the character at one index.
    //
    // Only O(log n) nodes need to be updated because we travel
    // from the root down to one leaf and then recalculate the
    // nodes on the way back up.
    // ------------------------------------------------------------
    void update(
      int node,
      int l,
      int r,
      int index,
      int value,
    ) {
      // We reached the character that needs to be changed.
      if (l == r) {
        leftChar[node] = value;
        rightChar[node] = value;

        leftRun[node] = 1;
        rightRun[node] = 1;
        best[node] = 1;

        return;
      }

      final int mid = (l + r) ~/ 2;

      // The index is inside the left child.
      if (index <= mid) {
        update(
          node * 2,
          l,
          mid,
          index,
          value,
        );
      }

      // The index is inside the right child.
      else {
        update(
          node * 2 + 1,
          mid + 1,
          r,
          index,
          value,
        );
      }

      // Recalculate this node because one of its children changed.
      pull(node, l, r);
    }

    // Build the initial segment tree.
    build(1, 0, n - 1);

    final List<int> answer = [];

    // ------------------------------------------------------------
    // Process all queries.
    // ------------------------------------------------------------
    for (int i = 0; i < k; i++) {
      final int index = queryIndices[i];

      // Character that should replace s[index].
      final int character = queryCharacters.codeUnitAt(i);

      // Perform the update.
      update(
        1,
        0,
        n - 1,
        index,
        character,
      );

      // The root represents the entire string.
      //
      // Therefore best[1] is the longest substring consisting
      // of a single repeating character.
      answer.add(best[1]);
    }

    return answer;
  }
}