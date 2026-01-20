function reverseKGroup(head: ListNode | null, k: number): ListNode | null {
    // Edge cases: empty list or k = 1 → no change
    if (!head || k === 1) return head;

    // Dummy node simplifies handling of head changes
    const dummy = new ListNode(0, head);

    // This pointer always points to the node BEFORE the group
    let groupPrev: ListNode | null = dummy;

    // Helper function:
    // Returns the k-th node starting from `node`
    // If fewer than k nodes remain, returns null
    const getKth = (node: ListNode | null, k: number): ListNode | null => {
        while (node && k > 0) {
            node = node.next;
            k--;
        }
        return node;
    };

    while (true) {
        // Find the k-th node from groupPrev
        const kth = getKth(groupPrev, k);
        if (!kth) break; // Not enough nodes left

        // Node right after the k-group
        const groupNext = kth.next;

        // Reverse the k nodes
        let prev: ListNode | null = groupNext;
        let curr: ListNode | null = groupPrev!.next;

        while (curr !== groupNext) {
            const temp = curr!.next;
            curr!.next = prev;
            prev = curr;
            curr = temp;
        }

        // Reconnect reversed group with previous part
        const oldGroupStart = groupPrev!.next;
        groupPrev!.next = kth;

        // Move groupPrev to the end of the reversed group
        groupPrev = oldGroupStart!;
    }

    return dummy.next;
}
