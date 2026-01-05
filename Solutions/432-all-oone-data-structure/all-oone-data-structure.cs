using System;
using System.Collections.Generic;

/// <summary>
/// AllOne data structure that supports O(1) increment, decrement, and getting max/min keys.
/// </summary>
public class AllOne
{
    /// <summary>
    /// Internal class representing a bucket of keys with the same count.
    /// </summary>
    private class Bucket
    {
        public int Count;                  // Count of the keys in this bucket
        public HashSet<string> Keys;       // All keys with this count
        public Bucket Prev, Next;          // Pointers to previous and next buckets

        public Bucket(int count)
        {
            Count = count;
            Keys = new HashSet<string>();
        }
    }

    private Bucket head, tail;               // Head = min count, Tail = max count
    private Dictionary<string, Bucket> key2Node; // Maps key -> its current bucket

    /// <summary>
    /// Initialize the data structure.
    /// </summary>
    public AllOne()
    {
        head = null;
        tail = null;
        key2Node = new Dictionary<string, Bucket>();
    }

    /// <summary>
    /// Increment the count of a key by 1.
    /// </summary>
    public void Inc(string key)
    {
        if (!key2Node.ContainsKey(key))
        {
            // Key is new → count = 1
            if (head == null || head.Count > 1)
            {
                // No bucket for count 1 → create it and insert at head
                Bucket newBucket = new Bucket(1);
                newBucket.Keys.Add(key);
                InsertBucketBefore(newBucket, head);
                head = newBucket;
                if (tail == null) tail = newBucket;
            }
            else
            {
                // Head bucket already has count 1 → just add key
                head.Keys.Add(key);
            }

            key2Node[key] = head;
        }
        else
        {
            // Key exists → move to next bucket (count + 1)
            Bucket curr = key2Node[key];
            Bucket next = curr.Next;

            if (next == null || next.Count > curr.Count + 1)
            {
                // No bucket for count + 1 → create it
                Bucket newBucket = new Bucket(curr.Count + 1);
                newBucket.Keys.Add(key);
                InsertBucketAfter(newBucket, curr);
                next = newBucket;
            }
            else
            {
                // Add key to existing next bucket
                next.Keys.Add(key);
            }

            // Remove key from current bucket
            curr.Keys.Remove(key);
            if (curr.Keys.Count == 0)
                RemoveBucket(curr); // remove empty bucket

            key2Node[key] = next;
        }
    }

    /// <summary>
    /// Decrement the count of a key by 1.
    /// If count becomes 0, remove the key completely.
    /// </summary>
    public void Dec(string key)
    {
        if (!key2Node.ContainsKey(key))
            return; // safe check, problem guarantees key exists

        Bucket curr = key2Node[key];

        if (curr.Count == 1)
        {
            // Remove key completely
            curr.Keys.Remove(key);
            key2Node.Remove(key);
            if (curr.Keys.Count == 0)
                RemoveBucket(curr); // update head/tail if needed
        }
        else
        {
            // Move key to previous bucket (count - 1)
            Bucket prev = curr.Prev;

            if (prev == null || prev.Count < curr.Count - 1)
            {
                // No bucket for count - 1 → create it
                Bucket newBucket = new Bucket(curr.Count - 1);
                newBucket.Keys.Add(key);
                InsertBucketBefore(newBucket, curr);
                prev = newBucket;
            }
            else
            {
                // Add to existing previous bucket
                prev.Keys.Add(key);
            }

            // Remove key from current bucket
            curr.Keys.Remove(key);
            if (curr.Keys.Count == 0)
                RemoveBucket(curr);

            key2Node[key] = prev;
        }
    }

    /// <summary>
    /// Return any key with the maximal count.
    /// </summary>
    public string GetMaxKey()
    {
        if (tail == null) return "";
        foreach (var key in tail.Keys)
            return key; // return any key
        return "";
    }

    /// <summary>
    /// Return any key with the minimal count.
    /// </summary>
    public string GetMinKey()
    {
        if (head == null) return "";
        foreach (var key in head.Keys)
            return key; // return any key
        return "";
    }

    /// <summary>
    /// Insert a new bucket after an existing bucket in the linked list.
    /// Updates tail if needed.
    /// </summary>
    private void InsertBucketAfter(Bucket newBucket, Bucket existing)
    {
        if (existing == null)
        {
            head = tail = newBucket;
            return;
        }

        newBucket.Prev = existing;
        newBucket.Next = existing.Next;
        if (existing.Next != null)
            existing.Next.Prev = newBucket;
        existing.Next = newBucket;

        if (tail == existing)
            tail = newBucket;
    }

    /// <summary>
    /// Insert a new bucket before an existing bucket in the linked list.
    /// Updates head if needed.
    /// </summary>
    private void InsertBucketBefore(Bucket newBucket, Bucket existing)
    {
        newBucket.Next = existing;
        if (existing != null)
        {
            newBucket.Prev = existing.Prev;
            if (existing.Prev != null)
                existing.Prev.Next = newBucket;
            existing.Prev = newBucket;
        }

        if (head == null || head == existing)
            head = newBucket;

        if (tail == null)
            tail = newBucket;
    }

    /// <summary>
    /// Remove a bucket from the linked list.
    /// Updates head/tail if needed.
    /// </summary>
    private void RemoveBucket(Bucket bucket)
    {
        if (bucket.Prev != null)
            bucket.Prev.Next = bucket.Next;
        else
            head = bucket.Next; // update head if first bucket removed

        if (bucket.Next != null)
            bucket.Next.Prev = bucket.Prev;
        else
            tail = bucket.Prev; // update tail if last bucket removed

        bucket.Prev = null;
        bucket.Next = null;
    }
}

/**
 * Example usage:
 * AllOne allOne = new AllOne();
 * allOne.Inc("hello"); // hello:1
 * allOne.Inc("hello"); // hello:2
 * allOne.Inc("world"); // world:1
 * allOne.Inc("world"); // world:2
 * allOne.Inc("hello"); // hello:3
 * allOne.Dec("world"); // world:1
 * Console.WriteLine(allOne.GetMaxKey()); // hello
 * Console.WriteLine(allOne.GetMinKey()); // world
 */
