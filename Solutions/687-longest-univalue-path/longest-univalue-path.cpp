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
    // Stores the final answer (maximum number of edges)
    int ans = 0;
    
    // Helper DFS function
    // Returns the longest downward path (in edges) with same value
    int dfs(TreeNode* node) {
        // Base case
        if (!node) return 0;
        
        // Recursively get left and right paths
        int leftLen = dfs(node->left);
        int rightLen = dfs(node->right);
        
        // These will store valid same-value paths
        int leftPath = 0;
        int rightPath = 0;
        
        // If left child exists and has same value
        if (node->left && node->left->val == node->val) {
            leftPath = leftLen + 1;
        }
        
        // If right child exists and has same value
        if (node->right && node->right->val == node->val) {
            rightPath = rightLen + 1;
        }
        
        // Update the global answer
        // Path may go left -> node -> right
        ans = max(ans, leftPath + rightPath);
        
        // Return the longest downward path
        return max(leftPath, rightPath);
    }
    
    int longestUnivaluePath(TreeNode* root) {
        dfs(root);
        return ans;
    }
};
