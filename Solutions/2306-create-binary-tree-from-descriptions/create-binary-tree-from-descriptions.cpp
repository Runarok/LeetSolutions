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
    TreeNode* createBinaryTree(vector<vector<int>>& descriptions) {
        
        // Map to store value -> TreeNode*
        unordered_map<int, TreeNode*> nodes;
        
        // Set to keep track of all nodes that appear as children
        unordered_set<int> children;
        
        // --------------------------------------------------
        // STEP 1: Create nodes and build parent-child links
        // --------------------------------------------------
        for (auto &desc : descriptions) {
            
            int parentVal = desc[0];
            int childVal  = desc[1];
            int isLeft    = desc[2];
            
            // Create parent node if it doesn't exist
            if (nodes.find(parentVal) == nodes.end()) {
                nodes[parentVal] = new TreeNode(parentVal);
            }
            
            // Create child node if it doesn't exist
            if (nodes.find(childVal) == nodes.end()) {
                nodes[childVal] = new TreeNode(childVal);
            }
            
            // Attach child to the correct side
            if (isLeft == 1) {
                nodes[parentVal]->left = nodes[childVal];
            } else {
                nodes[parentVal]->right = nodes[childVal];
            }
            
            // Mark this node as a child
            children.insert(childVal);
        }
        
        // ----------------------------------------
        // STEP 2: Find the root (never a child)
        // ----------------------------------------
        for (auto &pair : nodes) {
            int nodeVal = pair.first;
            
            // Root node does NOT appear in children set
            if (children.find(nodeVal) == children.end()) {
                return pair.second;
            }
        }
        
        // Problem guarantees a valid tree, so this won't happen
        return nullptr;
    }
};
