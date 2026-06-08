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
        
        // Maps a node value to its TreeNode pointer.
        // This allows us to quickly access/create nodes.
        unordered_map<int, TreeNode*> nodes;
        
        // Stores every value that appears as a child.
        // Root will never appear here.
        unordered_set<int> children;
        
        // Process every description
        for (auto &desc : descriptions) {
            
            // Extract information
            int parent = desc[0];
            int child = desc[1];
            int isLeft = desc[2];
            
            // If parent node doesn't exist yet,
            // create it and store it.
            if (nodes.find(parent) == nodes.end()) {
                nodes[parent] = new TreeNode(parent);
            }
            
            // If child node doesn't exist yet,
            // create it and store it.
            if (nodes.find(child) == nodes.end()) {
                nodes[child] = new TreeNode(child);
            }
            
            // Connect parent with child
            if (isLeft == 1) {
                
                // Child is the left child
                nodes[parent]->left = nodes[child];
                
            } else {
                
                // Child is the right child
                nodes[parent]->right = nodes[child];
            }
            
            // Mark this node as a child
            children.insert(child);
        }
        
        // Find the root.
        // Root is the node that never appears as a child.
        for (auto &desc : descriptions) {
            
            int parent = desc[0];
            
            // If parent is not present in the child set,
            // it must be the root.
            if (children.find(parent) == children.end()) {
                return nodes[parent];
            }
        }
        
        // According to constraints, a valid root always exists.
        return nullptr;
    }
};