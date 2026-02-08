# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        # An empty tree is always balanced
        if not root:
            return True
        
        # Call helper function starting with height = 1
        x = self.comparator(root, 1)
        
        # If comparator returns -1, tree is unbalanced
        if x == -1:
            return False
        
        return True    

    def comparator(self, node: Optional[TreeNode], height: int) -> int:
        # l and r will store the height of left and right subtrees
        l, r = 0, 0
        
        # If left child does not exist, current height is the left height
        if not node.left:
            l = height
        else:
            # Recursively compute left subtree height
            l = self.comparator(node.left, height + 1)
        
        # If right child does not exist, current height is the right height
        if not node.right:
            r = height
        else:
            # Recursively compute right subtree height
            r = self.comparator(node.right, height + 1)
        
        # If either subtree is already unbalanced, propagate -1 upward
        if l < 0 or r < 0:
            return -1
        
        # If height difference is more than 1, tree is unbalanced
        if abs(l - r) > 1:
            return -1
        
        # Return the maximum height of the subtree rooted at this node
        return max(l, r)
