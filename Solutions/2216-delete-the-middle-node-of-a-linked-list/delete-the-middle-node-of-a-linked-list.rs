impl Solution {
    pub fn delete_middle(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        // ------------------------------------------------------------
        // Special case:
        // If the list contains only one node, deleting the middle node
        // leaves us with an empty list.
        // ------------------------------------------------------------
        if head.as_ref().unwrap().next.is_none() {
            return None;
        }

        // ------------------------------------------------------------
        // First pass: count how many nodes are in the linked list.
        // ------------------------------------------------------------
        let mut len = 0;

        // `curr` is an immutable reference used only for counting.
        let mut curr = head.as_ref();

        while let Some(node) = curr {
            len += 1;
            curr = node.next.as_ref();
        }

        // ------------------------------------------------------------
        // The middle index using 0-based indexing.
        //
        // Example:
        // len = 7 -> middle = 3
        // len = 4 -> middle = 2
        // len = 2 -> middle = 1
        // ------------------------------------------------------------
        let middle = len / 2;

        // ------------------------------------------------------------
        // We need to stop at the node BEFORE the middle node.
        //
        // Example:
        // [1,3,4,7,1,2,6]
        //  0 1 2 3 4 5 6
        //
        // middle = 3
        // We stop at index 2 and make:
        // node[2].next = node[3].next
        // ------------------------------------------------------------
        let mut curr = head.as_mut();

        // Move to index (middle - 1).
        for _ in 0..middle - 1 {
            curr = curr.unwrap().next.as_mut();
        }

        // ------------------------------------------------------------
        // `curr` now points to the node before the middle.
        //
        // Save the middle node temporarily and then connect
        // current node directly to middle.next.
        // ------------------------------------------------------------
        let prev = curr.unwrap();

        // Take ownership of the middle node.
        let middle_node = prev.next.take();

        // If the middle node exists, connect around it.
        if let Some(mut node) = middle_node {
            prev.next = node.next.take();
        }

        // Return the modified list.
        head
    }
}   