class MyCircularQueue {

    // Array used to store queue elements
    private var queue: [Int]

    // Maximum size of the circular queue
    private var capacity: Int

    // Index pointing to the front element
    private var front: Int

    // Index pointing to the position
    // where the next element will be inserted
    private var rear: Int

    // Current number of elements in the queue
    private var count: Int

    // Initialize the circular queue with size k
    init(_ k: Int) {

        // Set the capacity of the queue
        self.capacity = k

        // Initialize the array with k elements
        // Default value does not matter as count controls validity
        self.queue = Array(repeating: 0, count: k)

        // Front starts at index 0
        self.front = 0

        // Rear also starts at index 0
        self.rear = 0

        // Initially, the queue is empty
        self.count = 0
    }

    // Insert an element into the circular queue
    func enQueue(_ value: Int) -> Bool {

        // If the queue is already full, insertion fails
        if isFull() {
            return false
        }

        // Insert the value at the rear position
        queue[rear] = value

        // Move rear forward circularly
        rear = (rear + 1) % capacity

        // Increase the number of elements in the queue
        count += 1

        // Insertion was successful
        return true
    }

    // Delete an element from the circular queue
    func deQueue() -> Bool {

        // If the queue is empty, deletion fails
        if isEmpty() {
            return false
        }

        // Move front forward circularly
        front = (front + 1) % capacity

        // Decrease the number of elements in the queue
        count -= 1

        // Deletion was successful
        return true
    }

    // Get the front element of the queue
    func Front() -> Int {

        // If the queue is empty, return -1
        if isEmpty() {
            return -1
        }

        // Return the front element
        return queue[front]
    }

    // Get the last element of the queue
    func Rear() -> Int {

        // If the queue is empty, return -1
        if isEmpty() {
            return -1
        }

        // Calculate the index of the last element
        let lastIndex = (rear - 1 + capacity) % capacity

        // Return the last element
        return queue[lastIndex]
    }

    // Check if the queue is empty
    func isEmpty() -> Bool {

        // Queue is empty when count is zero
        return count == 0
    }

    // Check if the queue is full
    func isFull() -> Bool {

        // Queue is full when count equals capacity
        return count == capacity
    }
}


/**
 * Your MyCircularQueue object will be instantiated and called as such:
 * let obj = MyCircularQueue(k)
 * let ret_1: Bool = obj.enQueue(value)
 * let ret_2: Bool = obj.deQueue()
 * let ret_3: Int = obj.Front()
 * let ret_4: Int = obj.Rear()
 * let ret_5: Bool = obj.isEmpty()
 * let ret_6: Bool = obj.isFull()
 */