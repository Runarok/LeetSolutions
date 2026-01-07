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

    func deleteDuplicates(_ head: ListNode?) -> ListNode? {

        // If the linked list is empty
        // there is nothing to remove
        if head == nil {
            return nil
        }

        // Create a variable to traverse the list
        // Start from the head node
        var current = head

        // Continue looping while the current node exists
        while current != nil {

            // Check if the next node exists
            // and has the same value as the current node
            if current?.next != nil && current!.val == current!.next!.val {

                // If duplicate is found
                // skip the next node
                current!.next = current!.next!.next

            } else {

                // If the next node is different
                // move the pointer forward
                current = current!.next
            }
        }

        // Return the head of the modified list
        return head
    }
}
