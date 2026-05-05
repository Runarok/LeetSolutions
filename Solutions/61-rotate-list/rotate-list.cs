public class Solution {
    public ListNode RotateRight(ListNode head, int k) {
        // Edge case: if the list is empty OR has only one node OR no rotation needed
        if (head == null || head.next == null || k == 0)
            return head;

        // Step 1: Find the length of the linked list
        int length = 1; // start from 1 because we already have head
        ListNode tail = head;

        // Traverse to the end to get length and last node (tail)
        while (tail.next != null) {
            tail = tail.next;
            length++;
        }

        // Step 2: Reduce k
        // Rotating by k is same as rotating by k % length
        k = k % length;

        // If k becomes 0 after modulo, no rotation needed
        if (k == 0)
            return head;

        // Step 3: Make the list circular
        // Connect the tail to the head
        tail.next = head;

        // Step 4: Find the new tail
        // New tail will be at position (length - k - 1)
        int stepsToNewTail = length - k - 1;
        ListNode newTail = head;

        // Move to the new tail
        for (int i = 0; i < stepsToNewTail; i++) {
            newTail = newTail.next;
        }

        // Step 5: The new head is next of new tail
        ListNode newHead = newTail.next;

        // Step 6: Break the circular link
        newTail.next = null;

        // Return the new head
        return newHead;
    }
}