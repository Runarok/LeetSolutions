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
    private let MOD = 1_000_000_007
    private var totalSum: Int = 0
    private var maxProductValue: Int64 = 0

    func maxProduct(_ root: TreeNode?) -> Int {
        // Step 1: Compute total sum of the tree
        totalSum = computeTotalSum(root)

        // Step 2: DFS again to compute subtree sums
        _ = computeSubtreeSum(root)

        // Return result modulo 1e9+7
        return Int(maxProductValue % Int64(MOD))
    }

    /// Computes the total sum of all nodes in the tree
    private func computeTotalSum(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        return node.val
            + computeTotalSum(node.left)
            + computeTotalSum(node.right)
    }

    /// Computes subtree sums and updates max product
    private func computeSubtreeSum(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }

        // Sum of left and right subtrees
        let leftSum = computeSubtreeSum(node.left)
        let rightSum = computeSubtreeSum(node.right)

        // Current subtree sum
        let subtreeSum = node.val + leftSum + rightSum

        // Product if we cut the edge above this subtree
        let product = Int64(subtreeSum) * Int64(totalSum - subtreeSum)

        // Update max product BEFORE modulo
        maxProductValue = max(maxProductValue, product)

        return subtreeSum
    }
}
