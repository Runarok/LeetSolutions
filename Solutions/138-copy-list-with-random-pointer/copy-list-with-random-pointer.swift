class Solution {

    func copyRandomList(_ head: Node?) -> Node? {

        // Step 1: Handle empty list
        // If head is nil, return nil immediately
        if head == nil {
            return nil
        }

        // Step 2: Interweave copied nodes with original nodes
        var current = head

        // Traverse the original list
        while current != nil {

            // Create a new node with the same value as current node
            let copy = Node(current!.val)

            // Insert the copy node immediately after the current node
            copy.next = current!.next
            current!.next = copy

            // Move to the next original node (skip the copy)
            current = copy.next
        }

        // Step 3: Assign random pointers to the copied nodes
        current = head

        // Traverse again
        while current != nil {

            // current.next is the copy node
            let copy = current!.next

            // Assign random pointer for copy node
            // If current.random is not nil, copy.random points to current.random.next
            // Otherwise, copy.random remains nil
            copy!.random = current!.random?.next

            // Move to the next original node (skip the copy)
            current = copy!.next
        }

        // Step 4: Separate the original list and copied list
        current = head
        let pseudoHead = Node(0) // Dummy head for copied list
        var copyCurrent: Node? = pseudoHead

        while current != nil {

            // current.next is the copy node
            let copy = current!.next

            // Append copy node to the copied list
            copyCurrent!.next = copy
            copyCurrent = copy

            // Restore the original list by skipping the copy
            current!.next = copy!.next

            // Move to the next original node
            current = current!.next
        }

        // Return the head of the copied list (skip dummy)
        return pseudoHead.next
    }
}
