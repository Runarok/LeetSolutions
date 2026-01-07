/**
 * Definition for singly-linked list.
 * class ListNode {
 *   int val;
 *   ListNode? next;
 *   ListNode([this.val = 0, this.next]);
 * }
 */

class Solution {
  ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
    // Create a dummy node to simplify edge cases.
    // 'tail' will always point to the last node of the merged list.
    ListNode dummy = ListNode(0);
    ListNode tail = dummy;

    // Iterate as long as both lists have nodes
    while (list1 != null && list2 != null) {
      if (list1.val <= list2.val) {
        // Attach list1 node to the merged list
        tail.next = list1;
        list1 = list1.next; // Move list1 pointer forward
      } else {
        // Attach list2 node to the merged list
        tail.next = list2;
        list2 = list2.next; // Move list2 pointer forward
      }
      tail = tail.next!; // Move tail to the last node
    }

    // At this point, at least one list is null.
    // Append the remaining nodes (if any) to the merged list.
    if (list1 != null) {
      tail.next = list1;
    } else {
      tail.next = list2;
    }

    // The merged list starts from dummy.next
    return dummy.next;
  }
}
