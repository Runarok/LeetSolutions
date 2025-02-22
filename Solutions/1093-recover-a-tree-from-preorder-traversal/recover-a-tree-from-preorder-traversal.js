/**
 * Definition for a binary tree node.
 * function TreeNode(val, left, right) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.left = (left===undefined ? null : left)
 *     this.right = (right===undefined ? null : right)
 * }
 */
/**
 * @param {string} traversal
 * @return {TreeNode}
 */

var recoverFromPreorder = function(traversal) {
    let stack = [];
    let i = 0;
    
    while (i < traversal.length) {
        let depth = 0;
        
        // Calculate the depth (number of dashes)
        while (traversal[i] === '-') {
            depth++;
            i++;
        }
        
        // Get the node's value
        let value = 0;
        while (i < traversal.length && !isNaN(traversal[i])) {
            value = value * 10 + Number(traversal[i]);
            i++;
        }
        
        // Create a new node
        let node = new TreeNode(value);
        
        // If the depth is greater than the current stack's length, it means it's a left child
        if (depth === stack.length) {
            if (stack.length > 0) {
                stack[stack.length - 1].left = node; // Add as left child
            }
        } else {
            // Pop the stack until we find the parent at the right depth
            while (stack.length > depth) {
                stack.pop();
            }
            stack[stack.length - 1].right = node; // Add as right child
        }
        
        // Push the node to the stack
        stack.push(node);
    }
    
    return stack[0]; // The root of the tree
};

// Definition for a binary tree node.
function TreeNode(val, left = null, right = null) {
    this.val = val;
    this.left = left;
    this.right = right;
}
