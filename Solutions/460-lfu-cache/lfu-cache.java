import java.util.*;

// LFU Cache implementation
class LFUCache {

    // -------------------------
    // Node class to store cache entries
    // -------------------------
    class Node {
        int key, value, freq; // key, value, and frequency
        Node prev, next;      // pointers for doubly linked list

        Node(int key, int value) {
            this.key = key;
            this.value = value;
            this.freq = 1; // new node starts with frequency 1
        }
    }

    // -------------------------
    // Doubly Linked List for nodes with same frequency
    // -------------------------
    class DLList {
        Node head, tail;
        int size;

        DLList() {
            head = new Node(0, 0); // dummy head
            tail = new Node(0, 0); // dummy tail
            head.next = tail;
            tail.prev = head;
            size = 0;
        }

        // Add node to the front (most recently used within this frequency)
        void addNode(Node node) {
            Node nextNode = head.next;
            head.next = node;
            node.prev = head;
            node.next = nextNode;
            nextNode.prev = node;
            size++;
        }

        // Remove a node from this list
        void removeNode(Node node) {
            node.prev.next = node.next;
            node.next.prev = node.prev;
            size--;
        }

        // Remove the least recently used node (tail.prev)
        Node removeTail() {
            if (size > 0) {
                Node node = tail.prev;
                removeNode(node);
                return node;
            }
            return null;
        }
    }

    // -------------------------
    // LFUCache fields
    // -------------------------
    private int capacity;                     // max cache size
    private int minFreq;                       // current minimum frequency
    private Map<Integer, Node> keyToNode;      // key -> Node mapping
    private Map<Integer, DLList> freqToList;   // freq -> doubly linked list of nodes

    // -------------------------
    // Constructor
    // -------------------------
    public LFUCache(int capacity) {
        this.capacity = capacity;
        this.minFreq = 0;
        keyToNode = new HashMap<>();
        freqToList = new HashMap<>();
    }

    // -------------------------
    // Get the value of a key
    // -------------------------
    public int get(int key) {

        // Key not found
        if (!keyToNode.containsKey(key)) return -1;

        // Get node and update its frequency
        Node node = keyToNode.get(key);
        updateNode(node);

        return node.value;
    }

    // -------------------------
    // Put a key-value pair into the cache
    // -------------------------
    public void put(int key, int value) {

        // Edge case: zero capacity
        if (capacity == 0) return;

        // If key already exists, update value and frequency
        if (keyToNode.containsKey(key)) {
            Node node = keyToNode.get(key);
            node.value = value;
            updateNode(node);

        } else {

            // If cache is full, remove LFU node
            if (keyToNode.size() >= capacity) {
                DLList minFreqList = freqToList.get(minFreq);
                Node toRemove = minFreqList.removeTail();
                keyToNode.remove(toRemove.key);
            }

            // Insert new node
            Node newNode = new Node(key, value);
            keyToNode.put(key, newNode);

            // Reset minFreq to 1 for new node
            minFreq = 1;

            // Add node to frequency list
            freqToList.putIfAbsent(1, new DLList());
            freqToList.get(1).addNode(newNode);
        }
    }

    // -------------------------
    // Helper function to update a node's frequency
    // -------------------------
    private void updateNode(Node node) {

        int freq = node.freq;

        // Remove node from current frequency list
        DLList oldList = freqToList.get(freq);
        oldList.removeNode(node);

        // If old list was minFreq and now empty, increase minFreq
        if (freq == minFreq && oldList.size == 0) {
            minFreq++;
        }

        // Increase node frequency
        node.freq++;

        // Add node to the new frequency list
        freqToList.putIfAbsent(node.freq, new DLList());
        freqToList.get(node.freq).addNode(node);
    }
}

/**
 * Your LFUCache object will be instantiated and called as such:
 * LFUCache obj = new LFUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */
