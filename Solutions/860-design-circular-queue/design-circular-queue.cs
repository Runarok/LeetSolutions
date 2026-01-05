using System;

/// <summary>
/// Implementation of a circular queue (ring buffer) using an array.
/// Supports O(1) enqueue, dequeue, front, rear, isEmpty, isFull operations.
/// </summary>
public class MyCircularQueue
{
    private int[] queue;    // Array to store elements
    private int front;      // Index of the front element
    private int rear;       // Index where the next element will be inserted
    private int size;       // Current number of elements
    private int capacity;   // Maximum capacity of the queue

    /// <summary>
    /// Initialize the queue with capacity k.
    /// </summary>
    public MyCircularQueue(int k)
    {
        capacity = k;               // Set maximum capacity
        queue = new int[k];         // Allocate array
        front = 0;                  // Front starts at 0
        rear = 0;                   // Rear also starts at 0
        size = 0;                   // Initially, queue is empty
    }

    /// <summary>
    /// Inserts an element into the circular queue.
    /// Returns true if the operation is successful.
    /// </summary>
    public bool EnQueue(int value)
    {
        if (IsFull()) return false;    // Cannot insert if queue is full

        queue[rear] = value;           // Place value at rear index
        rear = (rear + 1) % capacity;  // Move rear pointer in circular manner
        size++;                         // Increase the size
        return true;
    }

    /// <summary>
    /// Deletes an element from the circular queue.
    /// Returns true if the operation is successful.
    /// </summary>
    public bool DeQueue()
    {
        if (IsEmpty()) return false;    // Cannot dequeue if queue is empty

        front = (front + 1) % capacity; // Move front pointer in circular manner
        size--;                          // Decrease the size
        return true;
    }

    /// <summary>
    /// Gets the front item from the queue. Returns -1 if empty.
    /// </summary>
    public int Front()
    {
        if (IsEmpty()) return -1;
        return queue[front];            // Return element at front index
    }

    /// <summary>
    /// Gets the last item (rear) from the queue. Returns -1 if empty.
    /// </summary>
    public int Rear()
    {
        if (IsEmpty()) return -1;
        // Rear points to next insertion index, so rear element is at (rear - 1 + capacity) % capacity
        return queue[(rear - 1 + capacity) % capacity];
    }

    /// <summary>
    /// Checks whether the circular queue is empty.
    /// </summary>
    public bool IsEmpty()
    {
        return size == 0;
    }

    /// <summary>
    /// Checks whether the circular queue is full.
    /// </summary>
    public bool IsFull()
    {
        return size == capacity;
    }
}

/**
 * Example Usage:
 * MyCircularQueue circularQueue = new MyCircularQueue(3);
 * circularQueue.EnQueue(1); // true
 * circularQueue.EnQueue(2); // true
 * circularQueue.EnQueue(3); // true
 * circularQueue.EnQueue(4); // false (queue is full)
 * circularQueue.Rear();     // 3
 * circularQueue.IsFull();   // true
 * circularQueue.DeQueue();  // true
 * circularQueue.EnQueue(4); // true
 * circularQueue.Rear();     // 4
 */
