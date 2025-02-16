/**
 * Definition for singly-linked list.
 * function ListNode(val, next) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.next = (next===undefined ? null : next)
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2) {
    let dummyHead = new ListNode(0); // Dummy node to simplify code
    let current = dummyHead;         // Pointer to construct the result
    let carry = 0;                   // To keep track of carry

    // Traverse both linked lists
    while (l1 !== null || l2 !== null || carry !== 0) {
        let x = l1 !== null ? l1.val : 0; // Value of current node in l1, or 0 if l1 is exhausted
        let y = l2 !== null ? l2.val : 0; // Value of current node in l2, or 0 if l2 is exhausted
        
        let sum = x + y + carry; // Add values and carry
        carry = Math.floor(sum / 10); // Update carry
        current.next = new ListNode(sum % 10); // Create a new node with the sum's last digit
        current = current.next; // Move to the next node in the result
        
        // Move to the next node in l1 and l2, if available
        if (l1 !== null) l1 = l1.next;
        if (l2 !== null) l2 = l2.next;
    }
    
    return dummyHead.next; // Return the next node of dummyHead (actual result)
};
