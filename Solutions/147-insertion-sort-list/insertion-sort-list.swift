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
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        // Edge case: if the list is empty or has only one element, it's already sorted
        guard head != nil, head!.next != nil else {
            return head
        }
        
        // Create a dummy node which acts as the new sorted head
        // This simplifies insertion at the start of the sorted list
        let dummy = ListNode(0)
        
        // Current node we are going to insert into the sorted list
        var current = head
        
        // Iterate over each node in the original list
        while current != nil {
            // Keep track of the next node in the original list
            // because we will change current.next during insertion
            let nextNode = current!.next
            
            // Pointer to iterate through the sorted list starting from dummy
            var prev = dummy
            
            // Find the correct position to insert the current node
            // Stop when we find a node whose value is greater than current.val
            while prev.next != nil && prev.next!.val < current!.val {
                prev = prev.next!
            }
            
            // Insert current node into the sorted list
            current!.next = prev.next
            prev.next = current
            
            // Move to the next node in the original list
            current = nextNode
        }
        
        // The sorted list starts after the dummy node
        return dummy.next
    }
}
