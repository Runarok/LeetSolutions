/**
 * Definition for singly-linked list.
 * class ListNode(_x: Int = 0, _next: ListNode = null) {
 *   var next: ListNode = _next
 *   var x: Int = _x
 * }
 */

object Solution {
    def modifiedList(nums: Array[Int], head: ListNode): ListNode = {
        // Convert nums array to a HashSet for fast lookup
        val removeSet = nums.toSet

        // Dummy node to handle cases where head itself needs to be removed
        val dummy = new ListNode(0, head)
        var prev = dummy
        var curr = head

        // Traverse the linked list
        while (curr != null) {
            if (removeSet.contains(curr.x)) {
                // Skip the current node if its value is in nums
                prev.next = curr.next
            } else {
                // Move prev only if current node is not removed
                prev = curr
            }
            // Always move to the next node
            curr = curr.next
        }

        // Return the new head (dummy.next handles case where original head was removed)
        dummy.next
    }
}
