# @param {String[]} words
# @param {Integer} k
# @return {String[]}
def top_k_frequent(words, k)
  # Max-heap priority queue
  priority_queue = PriorityQueue.new

  # Build a hash that maps each word to an Element object
  # Default value creates a new Element with priority 0
  elements = words.each_with_object(Hash.new { |h, key| h[key] = Element.new(key) }) do |word, hash|
    # Increase frequency count for this word
    hash[word].priority += 1
  end

  # Push all Element objects into the priority queue
  elements.values.each { |element| priority_queue << element }

  # Extract the top k most frequent words
  (0...k).map { priority_queue.pop.key }
end

# Represents an item in the priority queue
class Element
  include Comparable

  attr_accessor :key, :priority

  def initialize(key, priority = 0)
    @key = key          # the word itself
    @priority = priority # frequency count
  end

  # Comparison logic for the max-heap
  # 1. Higher frequency comes first
  # 2. If frequencies are equal, lexicographically smaller word comes first
  def <=>(other)
    if @priority == other.priority
      # Reverse string comparison so "a" > "b" for max-heap behavior
      -(key <=> other.key)
    else
      @priority <=> other.priority
    end
  end
end

# Custom max-heap priority queue implementation
class PriorityQueue
  def initialize
    # Index 0 is unused to make parent/child math simpler
    @elements = [nil]
  end

  # Insert an element into the heap
  def <<(element)
    @elements << element
    bubble_up(@elements.size - 1)
  end

  # Move element up until heap property is restored
  def bubble_up(index)
    parent_index = index / 2

    # Stop if we reached the root
    return if index <= 1

    # Stop if parent is already larger or equal
    return if @elements[parent_index] >= @elements[index]

    # Swap child with parent
    exchange(index, parent_index)

    # Continue bubbling up
    bubble_up(parent_index)
  end

  # Swap two elements in the array
  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end

  # Remove and return the max element (root of heap)
  def pop
    # Move root to the end
    exchange(1, @elements.size - 1)

    # Remove the max element
    max = @elements.pop

    # Restore heap property
    bubble_down(1)

    max
  end

  # Move element down until heap property is restored
  def bubble_down(index)
    child_index = index * 2

    # Stop if there are no children
    return if child_index > @elements.size - 1

    # Check if right child exists
    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]
    right_element = @elements[child_index + 1]

    # Pick the larger child
    child_index += 1 if not_the_last_element && right_element > left_element

    # Stop if parent is already larger or equal
    return if @elements[index] >= @elements[child_index]

    # Swap parent with larger child
    exchange(index, child_index)

    # Continue bubbling down
    bubble_down(child_index)
  end
end
