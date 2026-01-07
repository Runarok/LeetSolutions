/**
 * Definition for a binary tree node.
 * class TreeNode {
 *   int val;
 *   TreeNode? left;
 *   TreeNode? right;
 *   TreeNode([this.val = 0, this.left, this.right]);
 * }
 */

class Solution {
  /// Main function to build the tree
  TreeNode? buildTree(List<int> inorder, List<int> postorder) {
    // Quick check: if either array is empty, return null
    if (inorder.isEmpty || postorder.isEmpty) return null;

    // Map to quickly find the index of a value in inorder array
    final Map<int, int> inorderIndexMap = {};
    for (int i = 0; i < inorder.length; i++) {
      inorderIndexMap[inorder[i]] = i;
    }

    /// Helper function: builds tree recursively
    /// inStart, inEnd: current bounds in inorder array
    /// postStart, postEnd: current bounds in postorder array
    TreeNode? helper(int inStart, int inEnd, int postStart, int postEnd) {
      // Base case: if there are no elements to construct subtree
      if (inStart > inEnd || postStart > postEnd) return null;

      // Last element in current postorder range is root
      int rootVal = postorder[postEnd];

      // Create the root node (nullable type TreeNode?)
      TreeNode? root = TreeNode(rootVal);

      // Find root's index in inorder array
      int inRootIndex = inorderIndexMap[rootVal]!;

      // Number of nodes in left subtree
      int leftTreeSize = inRootIndex - inStart;

      // Recursively build the left subtree
      root.left = helper(
        inStart,
        inRootIndex - 1,
        postStart,
        postStart + leftTreeSize - 1,
      );

      // Recursively build the right subtree
      root.right = helper(
        inRootIndex + 1,
        inEnd,
        postStart + leftTreeSize,
        postEnd - 1,
      );

      // Return the constructed subtree rooted at 'root'
      return root;
    }

    // Call helper for the entire array range
    return helper(0, inorder.length - 1, 0, postorder.length - 1);
  }
}
