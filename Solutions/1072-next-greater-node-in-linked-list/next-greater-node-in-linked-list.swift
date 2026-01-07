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

    func nextLargerNodes(_ head: ListNode?) -> [Int] {

        // Step 1: Convert the linked list to an array for easy indexing
        // Linked list traversal is sequential, but we need to access elements by index
        var values: [Int] = []
        var current = head
        while current != nil {
            values.append(current!.val) // add node value to array
            current = current!.next     // move to next node
        }

        // Step 2: Initialize the result array with 0s
        // Initially, we assume no next greater node exists
        var result = Array(repeating: 0, count: values.count)

        // Step 3: Initialize a stack to store indices
        // Stack will help us keep track of indices whose next greater value is not found yet
        var stack: [Int] = []

        // Step 4: Iterate through each value in the array
        for (i, value) in values.enumerated() {

            // While stack is not empty AND current value is greater than the value at the top index
            while let lastIndex = stack.last, value > values[lastIndex] {
                // The current value is the next greater for the node at lastIndex
                result[lastIndex] = value

                // Remove last index from stack since we have found its next greater
                stack.removeLast()
            }

            // Push current index onto stack
            // We will find its next greater later
            stack.append(i)
        }

        // Step 5: Any indices left in the stack have no next greater node
        // They are already initialized to 0 in the result array, so no action needed

        // Step 6: Return the result array
        return result
    }
}
