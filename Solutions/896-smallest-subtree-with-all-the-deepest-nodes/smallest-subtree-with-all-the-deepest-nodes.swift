/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */

class Solution {
    func subtreeWithAllDeepest(_ root: TreeNode?) -> TreeNode? {
        // Helper function for DFS
        func dfs(_ node: TreeNode?) -> (Int, TreeNode?) {
            guard let node = node else {
                return (0, nil) // Base case: null node
            }
            
            let (leftDepth, leftSubtree) = dfs(node.left)
            let (rightDepth, rightSubtree) = dfs(node.right)
            
            // If both left and right subtrees have the same depth, current node is the subtree with all deepest nodes
            if leftDepth == rightDepth {
                return (leftDepth + 1, node)
            }
            
            // Propagate the deeper subtree
            if leftDepth > rightDepth {
                return (leftDepth + 1, leftSubtree)
            } else {
                return (rightDepth + 1, rightSubtree)
            }
        }
        
        return dfs(root).1
    }
}
