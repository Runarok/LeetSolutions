/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public int val;
 *     public TreeNode left;
 *     public TreeNode right;
 *     public TreeNode(int val=0, TreeNode left=null, TreeNode right=null) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */


public class Solution {
    public int MaxLevelSum(TreeNode root) {
        // Queue for level-order traversal (BFS)
        Queue<TreeNode> queue = new Queue<TreeNode>();
        queue.Enqueue(root);

        // Current level number (root is level 1)
        int level = 1;

        // To track the answer
        int maxSum = int.MinValue;   // Best sum found so far
        int answerLevel = 1;         // Level with the best sum

        // Continue until all levels are processed
        while (queue.Count > 0) {
            int levelSize = queue.Count; // Number of nodes at this level
            int levelSum = 0;            // Sum of values at this level

            // Process all nodes at the current level
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.Dequeue();
                levelSum += node.val;

                // Add children to queue for next level
                if (node.left != null) {
                    queue.Enqueue(node.left);
                }
                if (node.right != null) {
                    queue.Enqueue(node.right);
                }
            }

            // If this level has a greater sum, update result
            if (levelSum > maxSum) {
                maxSum = levelSum;
                answerLevel = level;
            }

            // Move to next level
            level++;
        }

        return answerLevel;
    }
}
