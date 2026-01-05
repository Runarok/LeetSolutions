# Node class for doubly linked list
# Each node stores a key, value, and pointers to previous and next nodes
class Node
  attr_accessor :key, :value, :prev, :next

  def initialize(key, value)
    @key = key      # The key of the cache entry
    @value = value  # The value of the cache entry
    @prev = nil     # Pointer to the previous node in the list
    @next = nil     # Pointer to the next node in the list
  end
end

# LRUCache class
class LRUCache
  # Initialize the LRU Cache
  # capacity: Integer, maximum number of items in cache
  def initialize(capacity)
    @capacity = capacity    # Maximum number of items the cache can hold
    @hash = {}              # Hash map for O(1) access: key => Node

    # Dummy head and tail nodes to simplify edge cases (no nil checks needed)
    @head = Node.new(0, 0) # Head of the doubly linked list (most recently used)
    @tail = Node.new(0, 0) # Tail of the doubly linked list (least recently used)
    @head.next = @tail
    @tail.prev = @head
  end

  # Get the value of a key if it exists in the cache
  # key: Integer
  # return: Integer value if exists, else -1
  def get(key)
    if @hash.key?(key)
      node = @hash[key]  # Get the node from the hash map
      move_to_head(node) # Mark as recently used by moving it to the front
      return node.value  # Return the stored value
    else
      return -1          # Key not found
    end
  end

  # Add a key-value pair to the cache or update an existing key
  # key: Integer, value: Integer
  # return: void
  def put(key, value)
    if @hash.key?(key)
      # Key exists: update the value
      node = @hash[key]
      node.value = value    # Update value
      move_to_head(node)    # Move node to head as it's now most recently used
    else
      # Key does not exist: create new node
      node = Node.new(key, value)
      @hash[key] = node     # Add node to hash map for O(1) lookup
      add_node(node)        # Add node to the head of the doubly linked list

      if @hash.size > @capacity
        # Cache exceeded capacity: remove least recently used item
        lru = pop_tail       # Remove node from tail (least recently used)
        @hash.delete(lru.key) # Remove entry from hash map
      end
    end
  end

  private

  # Add a new node right after head (most recently used position)
  def add_node(node)
    node.prev = @head
    node.next = @head.next
    @head.next.prev = node
    @head.next = node
  end

  # Remove a node from its current position in the doubly linked list
  def remove_node(node)
    prev_node = node.prev
    next_node = node.next
    prev_node.next = next_node
    next_node.prev = prev_node
  end

  # Move a node to the head (mark as most recently used)
  def move_to_head(node)
    remove_node(node)  # Remove from current position
    add_node(node)     # Insert right after head
  end

  # Pop the last node (least recently used) from the list
  def pop_tail
    node = @tail.prev  # Node before dummy tail is the LRU
    remove_node(node)  # Remove it from the list
    node               # Return it so we can also remove from hash
  end
end
