/**
 * Definition for singly-linked list.
 */

class Solution {
  /// Merge k sorted linked lists into one sorted linked list
  ListNode? mergeKLists(List<ListNode?> lists) {
    if (lists.isEmpty) return null;
    return mergeRange(lists, 0, lists.length - 1);
  }

  /// Helper: merge lists in range [left, right] using divide and conquer
  ListNode? mergeRange(List<ListNode?> lists, int left, int right) {
    if (left == right) return lists[left];
    int mid = left + (right - left) ~/ 2;
    ListNode? l1 = mergeRange(lists, left, mid);
    ListNode? l2 = mergeRange(lists, mid + 1, right);
    return mergeTwoLists(l1, l2);
  }

  /// Merge two sorted linked lists
  ListNode? mergeTwoLists(ListNode? l1, ListNode? l2) {
    ListNode dummy = ListNode(-1);
    ListNode current = dummy;

    while (l1 != null && l2 != null) {
      if (l1.val < l2.val) {
        current.next = l1;
        l1 = l1.next;
      } else {
        current.next = l2;
        l2 = l2.next;
      }
      current = current.next!;
    }

    // Append remaining nodes
    if (l1 != null) current.next = l1;
    if (l2 != null) current.next = l2;

    return dummy.next;
  }
}
