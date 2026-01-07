# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end

# @param {TreeNode} root
# @param {Integer} low
# @param {Integer} high
# @return {TreeNode}
def trim_bst(root, low, high)
  return nil if root.nil? # Base case: empty node

  if root.val < low
    # Node too small, trim left subtree entirely
    return trim_bst(root.right, low, high)
  elsif root.val > high
    # Node too large, trim right subtree entirely
    return trim_bst(root.left, low, high)
  end

  # Node is within range, keep it
  root.left = trim_bst(root.left, low, high) # Trim left subtree
  root.right = trim_bst(root.right, low, high) # Trim right subtree

  return root # Return trimmed subtree rooted at this node
end
