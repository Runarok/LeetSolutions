func maxPathSum(root *TreeNode) int {
    // ------------------------------------------------------------
    // PROBLEM SUMMARY (COMMENTS ONLY)
    // ------------------------------------------------------------
    //
    // We are given a binary tree where each node has an integer value.
    //
    // A PATH is defined as:
    //   - Any sequence of nodes connected by edges
    //   - Each node can appear AT MOST ONCE
    //   - Path does NOT need to pass through the root
    //   - Path must be NON-EMPTY
    //
    // The PATH SUM is the sum of node values along the path.
    //
    // Goal:
    //   Find the MAXIMUM possible path sum.
    //
    // ------------------------------------------------------------
    // KEY OBSERVATIONS
    // ------------------------------------------------------------
    //
    // 1) A path can:
    //    - Go down the left subtree
    //    - Go down the right subtree
    //    - Go through a node using BOTH left and right
    //
    // 2) When returning values upward in recursion:
    //    - We can only return ONE direction (left OR right)
    //    - Because a parent path cannot branch
    //
    // 3) However, when computing the global answer:
    //    - We ARE allowed to use BOTH left and right
    //
    // ------------------------------------------------------------
    // STRATEGY (DFS + RECURSION)
    // ------------------------------------------------------------
    //
    // For each node, compute:
    //
    //   maxGain(node):
    //     = maximum path sum starting at this node
    //       and extending DOWNWARD in ONE direction
    //
    // At each node:
    //   - Ignore negative gains (they only reduce the sum)
    //   - Compute:
    //       leftGain  = max(0, maxGain(left))
    //       rightGain = max(0, maxGain(right))
    //
    //   - Possible path THROUGH this node:
    //       node.Val + leftGain + rightGain
    //
    //   - Update global maximum if this path is better
    //
    //   - Return to parent:
    //       node.Val + max(leftGain, rightGain)
    //
    // ------------------------------------------------------------
    // EDGE CASE
    // ------------------------------------------------------------
    //
    // Tree can contain ALL NEGATIVE values.
    // Therefore:
    //   - Global maximum must start at -infinity
    //
    // ------------------------------------------------------------

    // Initialize global maximum path sum to the smallest integer
    maxSum := -1 << 31 // equivalent to math.MinInt32

    // Helper DFS function
    var dfs func(node *TreeNode) int

    dfs = func(node *TreeNode) int {
        // Base case: empty node contributes nothing
        if node == nil {
            return 0
        }

        // Recursively compute max downward gain from left subtree
        leftGain := dfs(node.Left)

        // Recursively compute max downward gain from right subtree
        rightGain := dfs(node.Right)

        // If a subtree contributes a negative sum,
        // we ignore it by clamping to 0
        if leftGain < 0 {
            leftGain = 0
        }
        if rightGain < 0 {
            rightGain = 0
        }

        // Compute the path sum that passes THROUGH this node
        // (can include both left and right children)
        currentPathSum := node.Val + leftGain + rightGain

        // Update the global maximum path sum if needed
        if currentPathSum > maxSum {
            maxSum = currentPathSum
        }

        // Return the maximum gain if we extend the path upward
        // (must choose ONLY ONE side)
        if leftGain > rightGain {
            return node.Val + leftGain
        }
        return node.Val + rightGain
    }

    // Start DFS from the root
    dfs(root)

    // maxSum now contains the maximum path sum in the tree
    return maxSum
}
