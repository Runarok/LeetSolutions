/**
 * Definition for singly-linked list.
 * class ListNode {
 *   int val;
 *   ListNode? next;
 *   ListNode([this.val = 0, this.next]);
 * }
 */

class Solution {
  int getDecimalValue(ListNode? head) {
    // This will store the resulting decimal value
    int result = 0;

    // Traverse the linked list node by node
    while (head != null) {
      // Shift the current result left by 1 bit to make room for the next bit
      // This is equivalent to result = result * 2
      result = result << 1;

      // Add the current node's value (either 0 or 1)
      result = result | head.val;

      // Move to the next node in the list
      head = head.next;
    }

    // Return the final decimal value after processing all bits
    return result;
  }
}
