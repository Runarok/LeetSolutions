/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */

class Solution {
public:
    bool hasCycle(ListNode *head) {
        // Step 1: Handle edge cases: empty list or single node with no cycle
        if (head == nullptr || head->next == nullptr) return false;
        
        // Step 2: Initialize two pointers
        ListNode* slow = head;       // Moves one step at a time
        ListNode* fast = head->next; // Moves two steps at a time
        
        // Step 3: Traverse the list
        while (slow != fast) {
            // If fast reaches the end, there is no cycle
            if (fast == nullptr || fast->next == nullptr) return false;
            
            // Move pointers forward
            slow = slow->next;          // one step
            fast = fast->next->next;    // two steps
        }
        
        // Step 4: If slow == fast, a cycle exists
        return true;
    }
};
