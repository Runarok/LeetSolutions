impl Solution {
    pub fn pair_sum(head: Option<Box<ListNode>>) -> i32 {
        // ------------------------------------------------------------
        // STEP 1: Find the middle of the linked list.
        //
        // We use slow and fast pointers:
        // - slow moves 1 step at a time
        // - fast moves 2 steps at a time
        //
        // When fast reaches the end, slow will be at the middle.
        // ------------------------------------------------------------
        let mut slow = head.as_ref();
        let mut fast = head.as_ref();

        while let Some(f) = fast {
            if let Some(next_fast) = f.next.as_ref() {
                slow = slow.unwrap().next.as_ref();
                fast = next_fast.next.as_ref();
            } else {
                break;
            }
        }

        // ------------------------------------------------------------
        // STEP 2: Reverse the second half of the list.
        //
        // Collect values from the middle onward in reversed order.
        //
        // Example:
        // List = 5 -> 4 -> 2 -> 1
        // Middle starts at 2 -> 1
        //
        // Reversed values become:
        // [1, 2]
        //
        // This allows us to pair:
        // 5 with 1
        // 4 with 2
        // ------------------------------------------------------------
        let mut reversed_second_half = Vec::new();

        let mut curr = slow;
        while let Some(node) = curr {
            reversed_second_half.push(node.val);
            curr = node.next.as_ref();
        }

        reversed_second_half.reverse();

        // ------------------------------------------------------------
        // STEP 3: Traverse the first half and compute twin sums.
        //
        // Since the second half values are stored reversed,
        // index i corresponds exactly to the twin of node i.
        // ------------------------------------------------------------
        let mut answer = 0;
        let mut curr = head.as_ref();

        for twin_val in reversed_second_half {
            if let Some(node) = curr {
                answer = answer.max(node.val + twin_val);
                curr = node.next.as_ref();
            }
        }

        // ------------------------------------------------------------
        // STEP 4: Return the maximum twin sum found.
        // ------------------------------------------------------------
        answer
    }
}