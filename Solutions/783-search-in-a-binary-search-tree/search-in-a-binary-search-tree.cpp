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
    TreeNode* searchBST(TreeNode* root, int val) {
        
        // Traverse the tree until root becomes null
        while (root != nullptr) {
            
            // If value matches, return current node
            if (root->val == val) {
                return root;
            }
            // If target value is smaller, go left
            else if (val < root->val) {
                root = root->left;
            }
            // If target value is larger, go right
            else {
                root = root->right;
            }
        }
        
        // Value not found
        return nullptr;
    }
};
