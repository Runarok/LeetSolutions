class Trie {
  // Serialized representation of this node
  String serial = '';
  // Map of child nodes
  Map<String, Trie> children = {};

  Trie();
}

class Solution {
  List<List<String>> deleteDuplicateFolder(List<List<String>> paths) {
    // Root node of the Trie
    Trie root = Trie();

    // Build the Trie from the list of paths
    for (List<String> path in paths) {
      Trie current = root;
      for (String folder in path) {
        current.children.putIfAbsent(folder, () => Trie());
        current = current.children[folder]!;
      }
    }

    // HashMap to store frequency of serialized subtrees
    Map<String, int> freq = {};

    // Helper function to construct the serialization of each subtree (post-order DFS)
    String construct(Trie node) {
      // If it’s a leaf node, return empty serialization
      if (node.children.isEmpty) return '';

      // List to collect serialized representations of children
      List<String> serializedChildren = [];

      // Traverse each child
      node.children.forEach((folder, child) {
        String childSerial = construct(child);
        serializedChildren.add('$folder($childSerial)');
      });

      // Sort the serialized list to ensure consistent representation regardless of order
      serializedChildren.sort();

      // Combine into a single string and store it
      node.serial = serializedChildren.join();

      // Count frequency of each serialized subtree
      freq[node.serial] = (freq[node.serial] ?? 0) + 1;

      return node.serial;
    }

    // Start serialization from the root
    construct(root);

    List<List<String>> result = [];
    List<String> currentPath = [];

    // DFS to collect valid paths (those not part of duplicate subtrees)
    void collect(Trie node) {
      // If current subtree is a duplicate, skip it
      if (freq[node.serial] != null && freq[node.serial]! > 1) {
        return;
      }

      // Add current valid path to result (except for root)
      if (currentPath.isNotEmpty) {
        result.add(List.from(currentPath));
      }

      // Continue DFS traversal
      node.children.forEach((folder, child) {
        currentPath.add(folder);
        collect(child);
        currentPath.removeLast();
      });
    }

    // Start collecting from root
    collect(root);

    return result;
  }
}
