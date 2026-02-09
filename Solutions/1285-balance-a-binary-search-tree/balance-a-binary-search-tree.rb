# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

# Main function:
# Takes an unbalanced BST and returns a balanced BST
def balance_bst(root)
    # Step 1: Convert BST to a sorted array using inorder traversal
    inorder = bst_to_inorder(root)

    # Step 2: Build a balanced BST from the sorted array
    inorder_to_balanced_bst(inorder)
end

# Performs an inorder traversal of the BST
# Inorder traversal of a BST gives values in sorted order
def bst_to_inorder(root)
    # Base case: empty node returns empty array
    return [] unless root

    # Traverse left subtree
    # Visit current node
    # Traverse right subtree
    bst_to_inorder(root.left) + [root] + bst_to_inorder(root.right)
end

# Builds a balanced BST from a sorted array of TreeNodes
def inorder_to_balanced_bst(inorder)
    # Get number of nodes in array
    n = inorder.size

    # Base case: empty array means no tree
    return if n == 0

    # Choose middle element to ensure balance
    mid = n / 2

    # The middle element becomes the root
    root = inorder[mid]

    # Recursively build left subtree from left half
    root.left = inorder_to_balanced_bst(inorder[...mid])

    # Recursively build right subtree from right half
    root.right = inorder_to_balanced_bst(inorder[mid + 1..])

    # Return the balanced root
    root
end
