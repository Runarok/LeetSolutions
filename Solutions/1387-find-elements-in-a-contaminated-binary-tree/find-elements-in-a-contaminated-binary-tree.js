/**
 * Definition for a binary tree node.
 * function TreeNode(val, left, right) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.left = (left===undefined ? null : left)
 *     this.right = (right===undefined ? null : right)
 * }
 */

/**
 * @param {TreeNode} root
 */
var FindElements = function(root) {
    // A set to keep track of recovered values in the binary tree.
    this.recoveredValues = new Set();
    
    // Helper function to recursively recover the binary tree and store valid values
    const recoverTree = (node, value) => {
        if (!node) return;
        
        // Recover the value for the current node.
        node.val = value;
        
        // Store the recovered value.
        this.recoveredValues.add(value);
        
        // Recursively recover left and right subtrees, adjusting the values according to the problem rules.
        if (node.left) recoverTree(node.left, 2 * value + 1);
        if (node.right) recoverTree(node.right, 2 * value + 2);
    };
    
    // Start the recovery process from the root node (initially contaminated).
    recoverTree(root, 0);
};

/** 
 * @param {number} target
 * @return {boolean}
 */
FindElements.prototype.find = function(target) {
    // Simply check if the target value exists in the set of recovered values.
    return this.recoveredValues.has(target);
};

/** 
 * Your FindElements object will be instantiated and called as such:
 * var obj = new FindElements(root)
 * var param_1 = obj.find(target)
 */
