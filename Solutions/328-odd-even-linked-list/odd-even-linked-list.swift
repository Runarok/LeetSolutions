/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

class Solution {

    func oddEvenList(_ head: ListNode?) -> ListNode? {

        // If the list is empty
        // there is nothing to reorder
        if head == nil {
            return nil
        }

        // Pointer to the first odd-indexed node
        // This starts at the head (index 1)
        var odd = head

        // Pointer to the first even-indexed node
        // This starts at the second node (index 2)
        var even = head?.next

        // Save the head of the even list
        // so we can attach it after odd list later
        let evenHead = even

        // Continue while there are still even nodes
        // and nodes after even nodes
        while even != nil && even?.next != nil {

            // Link current odd node to the next odd node
            // Skipping the current even node
            odd?.next = even?.next

            // Move odd pointer forward
            odd = odd?.next

            // Link current even node to the next even node
            // Skipping the new odd node
            even?.next = odd?.next

            // Move even pointer forward
            even = even?.next
        }

        // After grouping all odd nodes
        // attach the even list at the end
        odd?.next = evenHead

        // Return the reordered list head
        return head
    }
}
