/**
 * Definition for a binary tree node.
 * class TreeNode(var `val`: Int) {
 *     var left: TreeNode? = null
 *     var right: TreeNode? = null
 * }
 */

class Solution {

    fun sumRootToLeaf(root: TreeNode?): Int {
        
        // This variable will store the final total sum
        var totalSum = 0
        
        // Helper function for DFS traversal
        // currentValue stores the number formed so far from root to this node
        fun dfs(node: TreeNode?, currentValue: Int) {
            
            // Base case:
            // If the node is null, there is nothing to process
            if (node == null) {
                return
            }
            
            // Update the current binary number
            // Multiply previous value by 2 (left shift)
            // Then add current node's value (0 or 1)
            val newValue = currentValue * 2 + node.`val`
            
            // Check if this node is a leaf
            // A leaf has no left child and no right child
            if (node.left == null && node.right == null) {
                
                // Add the computed binary number to total sum
                totalSum += newValue
                
                // Return because no further children to explore
                return
            }
            
            // Recursively explore the left subtree
            dfs(node.left, newValue)
            
            // Recursively explore the right subtree
            dfs(node.right, newValue)
        }
        
        // Start DFS from root
        // Initial binary value is 0
        dfs(root, 0)
        
        // Return the final accumulated sum
        return totalSum
    }
}