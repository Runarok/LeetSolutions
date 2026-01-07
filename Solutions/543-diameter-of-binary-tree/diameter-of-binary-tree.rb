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
# @return {Integer}
def diameter_of_binary_tree(root)
  @max_diameter = 0

  # Helper function to compute height of tree
  def height(node)
    return 0 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    # Update the diameter at this node
    @max_diameter = [@max_diameter, left_height + right_height].max

    # Return height of this node
    1 + [left_height, right_height].max
  end

  height(root)
  @max_diameter
end
