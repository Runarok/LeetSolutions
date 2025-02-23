/**
 * Definition for a binary tree node.
 * function TreeNode(val, left, right) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.left = (left===undefined ? null : left)
 *     this.right = (right===undefined ? null : right)
 * }
 */
/**
 * @param {number[]} preorder
 * @param {number[]} postorder
 * @return {TreeNode}
 */


function TreeNode(val, left = null, right = null) {
    this.val = val;
    this.left = left;
    this.right = right;
}

var constructFromPrePost = function(preorder, postorder) {
    // Map for fast lookup of the index of each element in postorder
    const postIndex = new Map();
    for (let i = 0; i < postorder.length; i++) {
        postIndex.set(postorder[i], i);
    }
    
    // Helper function to recursively build the tree
    function build(preStart, preEnd, postStart, postEnd) {
        if (preStart > preEnd || postStart > postEnd) return null;
        
        // The first element in preorder is the root
        let rootVal = preorder[preStart];
        let root = new TreeNode(rootVal);
        
        if (preStart === preEnd) return root; // Only one element
        
        // The second element in preorder is the left subtree's root
        let leftRootVal = preorder[preStart + 1];
        
        // Find the left subtree's root in postorder
        let leftSubtreeEnd = postIndex.get(leftRootVal);
        
        // Number of elements in the left subtree
        let leftSubtreeSize = leftSubtreeEnd - postStart + 1;
        
        // Build the left and right subtrees recursively
        root.left = build(preStart + 1, preStart + leftSubtreeSize, postStart, leftSubtreeEnd);
        root.right = build(preStart + leftSubtreeSize + 1, preEnd, leftSubtreeEnd + 1, postEnd - 1);
        
        return root;
    }
    
    // Call the helper function for the whole range
    return build(0, preorder.length - 1, 0, postorder.length - 1);
};
