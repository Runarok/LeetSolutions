function averageOfSubtree(root: TreeNode | null): number {
    // This variable keeps track of how many nodes
    // satisfy the condition:
    // node.val === floor(average of its subtree)
    let answer = 0;

    // DFS returns two pieces of information for every subtree:
    // 1. The sum of all values in that subtree
    // 2. The number of nodes in that subtree
    function dfs(node: TreeNode | null): [number, number] {
        // If there is no node, the subtree has:
        // sum = 0
        // count = 0
        if (node === null) {
            return [0, 0];
        }

        // First, process the left subtree.
        //
        // We need its sum and node count so that
        // we can include them when calculating
        // the average for the current node.
        const [leftSum, leftCount] = dfs(node.left);

        // Then, process the right subtree.
        const [rightSum, rightCount] = dfs(node.right);

        // The current subtree contains:
        //
        //      current node
        //      + all nodes in the left subtree
        //      + all nodes in the right subtree
        //
        // Therefore, its total sum is:
        const sum = node.val + leftSum + rightSum;

        // And its total number of nodes is:
        const count = 1 + leftCount + rightCount;

        // JavaScript/TypeScript division gives us a decimal.
        //
        // The problem says the average must be rounded DOWN,
        // so we use Math.floor().
        //
        // Example:
        // 11 / 2 = 5.5
        // Math.floor(5.5) = 5
        const average = Math.floor(sum / count);

        // Check whether the current node's value
        // is equal to the average of its entire subtree.
        //
        // If it is, this node should be counted.
        if (node.val === average) {
            answer++;
        }

        // Return the information about this subtree
        // to the parent node.
        return [sum, count];
    }

    // Start DFS from the root.
    dfs(root);

    // Return the total number of nodes
    // whose value equals their subtree average.
    return answer;
}
