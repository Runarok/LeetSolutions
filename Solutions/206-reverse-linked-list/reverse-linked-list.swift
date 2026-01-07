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

    // Iterative version of reversing a linked list
    func reverseList(_ head: ListNode?) -> ListNode? {

        // If the list is empty or has only one node
        // return it as is
        if head == nil || head?.next == nil {
            return head
        }

        // Initialize a pointer for the previous node
        // Start with nil because new tail will point to nil
        var prev: ListNode? = nil

        // Initialize a pointer for the current node
        // Start from the head of the list
        var current = head

        // Loop through the list until we reach the end
        while current != nil {

            // Save the next node temporarily
            // Because we will change current.next
            let nextTemp = current!.next

            // Reverse the link: point current node to previous node
            current!.next = prev

            // Move previous node pointer forward
            prev = current

            // Move current node pointer forward
            current = nextTemp
        }

        // When the loop ends, prev points to the new head
        return prev
    }

    // Recursive version of reversing a linked list
    func reverseListRecursive(_ head: ListNode?) -> ListNode? {

        // Base case: empty list or single node list
        if head == nil || head?.next == nil {
            return head
        }

        // Recursively reverse the rest of the list
        let newHead = reverseListRecursive(head?.next)

        // Reverse the link for the current node
        head?.next?.next = head

        // Set current node next to nil (new tail)
        head?.next = nil

        // Return new head of the reversed list
        return newHead
    }
}
