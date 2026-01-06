class MyQueue {
    
    // Stack to handle incoming elements (push operations)
    private var inStack: [Int]
    // Stack to handle outgoing elements (pop/peek operations)
    private var outStack: [Int]

    /** Initialize your data structure here. */
    init() {
        inStack = []   // Start with empty stack for pushing
        outStack = []  // Start with empty stack for popping/peeking
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        // Always push new elements onto inStack
        // This maintains O(1) push time
        inStack.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        // If outStack is empty, we need to reverse inStack into it
        // This way the oldest element is on top of outStack
        if outStack.isEmpty {
            // Transfer all elements from inStack to outStack
            // This reverses their order, making queue's front accessible
            while !inStack.isEmpty {
                let top = inStack.removeLast() // pop from inStack
                outStack.append(top)           // push onto outStack
            }
        }
        // Now outStack's top element is the front of the queue
        return outStack.removeLast()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        // Same transfer logic as pop
        if outStack.isEmpty {
            while !inStack.isEmpty {
                let top = inStack.removeLast()
                outStack.append(top)
            }
        }
        // Peek at the top of outStack without removing
        return outStack.last!
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        // Queue is empty only if both stacks are empty
        return inStack.isEmpty && outStack.isEmpty
    }
}

/**
 * Usage example:
 * let obj = MyQueue()
 * obj.push(1)     // queue: [1]
 * obj.push(2)     // queue: [1, 2]
 * let front = obj.peek()  // returns 1
 * let popped = obj.pop()  // returns 1, queue now: [2]
 * let isEmpty = obj.empty() // returns false
 */
