# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end

# @param {ListNode[]} lists
# @return {ListNode}
def merge_k_lists(lists)
  # Remove nil lists
  heap = lists.compact

  # Edge case: if all lists are empty
  return nil if heap.empty?

  # Dummy node to build result
  dummy = ListNode.new(0)
  current = dummy

  # Sort initial heap based on node values
  heap.sort_by! { |node| node.val }

  while !heap.empty?
    # Take the smallest node
    smallest = heap.shift

    # Attach to result
    current.next = smallest
    current = current.next

    # If there's a next node, add it to heap
    if smallest.next
      heap << smallest.next
      heap.sort_by! { |node| node.val }  # re-sort heap
    end
  end

  return dummy.next
end