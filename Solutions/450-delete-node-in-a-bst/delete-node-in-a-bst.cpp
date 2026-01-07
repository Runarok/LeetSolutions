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
    
    // Helper function to find the minimum value node
    // (leftmost node in a subtree)
    TreeNode* findMin(TreeNode* node) {
        while (node && node->left) {
            node = node->left;
        }
        return node;
    }
    
    TreeNode* deleteNode(TreeNode* root, int key) {
        
        // -------------------------
        // BASE CASE
        // -------------------------
        if (!root) {
            return nullptr;
        }
        
        // -------------------------
        // STEP 1: SEARCH THE NODE
        // -------------------------
        if (key < root->val) {
            // Key is smaller → go left
            root->left = deleteNode(root->left, key);
        }
        else if (key > root->val) {
            // Key is larger → go right
            root->right = deleteNode(root->right, key);
        }
        else {
            // -------------------------
            // STEP 2: DELETE THE NODE
            // -------------------------
            
            // CASE 1: No left child
            if (!root->left) {
                TreeNode* rightChild = root->right;
                delete root;
                return rightChild;
            }
            
            // CASE 2: No right child
            else if (!root->right) {
                TreeNode* leftChild = root->left;
                delete root;
                return leftChild;
            }
            
            // CASE 3: Two children
            else {
                // Find inorder successor (smallest in right subtree)
                TreeNode* successor = findMin(root->right);
                
                // Copy successor's value to current node
                root->val = successor->val;
                
                // Delete successor node from right subtree
                root->right = deleteNode(root->right, successor->val);
            }
        }
        
        // Return updated root
        return root;
    }
};
