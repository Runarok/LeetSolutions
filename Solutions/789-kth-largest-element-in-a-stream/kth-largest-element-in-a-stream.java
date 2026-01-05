import java.util.*;

// KthLargest class to track the kth largest element in a dynamic stream
class KthLargest {

    // -------------------------
    // Fields
    // -------------------------
    private PriorityQueue<Integer> minHeap; // min-heap to store the k largest numbers
    private int k;                          // the kth largest we are tracking

    // -------------------------
    // Constructor
    // -------------------------
    public KthLargest(int k, int[] nums) {

        this.k = k;

        // Min-heap to keep track of the k largest elements
        minHeap = new PriorityQueue<>();

        // Add all initial numbers into the heap
        for (int num : nums) {
            add(num); // reuse add method to maintain heap property
        }
    }

    // -------------------------
    // Add a new value and return the kth largest element
    // -------------------------
    public int add(int val) {

        // Add the new value into the heap
        minHeap.offer(val);

        // If heap size exceeds k, remove the smallest element
        // This ensures only k largest elements remain in the heap
        if (minHeap.size() > k) {
            minHeap.poll();
        }

        // The root of the heap is now the kth largest element
        return minHeap.peek();
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * KthLargest obj = new KthLargest(k, nums);
 * int param_1 = obj.add(val);
 */
