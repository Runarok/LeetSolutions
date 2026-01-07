/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
 * };
 */

class Solution {
public:
    TreeNode* insertIntoBST(TreeNode* root, int val) {
        
        // If tree is empty, return new node as root
        if (!root) {
            return new TreeNode(val);
        }
        
        TreeNode* curr = root;
        
        while (true) {
            // Go to left subtree
            if (val < curr->val) {
                if (curr->left) {
                    curr = curr->left;
                } else {
                    curr->left = new TreeNode(val);
                    break;
                }
            }
            // Go to right subtree
            else {
                if (curr->right) {
                    curr = curr->right;
                } else {
                    curr->right = new TreeNode(val);
                    break;
                }
            }
        }
        
        // Root remains unchanged
        return root;
    }
};
