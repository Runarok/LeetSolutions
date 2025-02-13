class MinHeap
  def initialize
    @heap = []
  end
  
  def push(val)
    @heap.push(val)
    # Maintain the heap property by performing heapify-up
    heapify_up(@heap.size - 1)
  end
  
  def pop
    return nil if @heap.empty?
    
    # Swap the root with the last element and pop the last element
    swap(0, @heap.size - 1)
    min = @heap.pop
    # Perform heapify-down to restore the heap property
    heapify_down(0)
    min
  end
  
  def peek
    @heap.first
  end
  
  def size
    @heap.size
  end

  private
  
  def heapify_up(index)
    # Heapify up to maintain heap property
    parent = (index - 1) / 2
    return if index <= 0 || @heap[parent] <= @heap[index]
    
    swap(parent, index)
    heapify_up(parent)
  end
  
  def heapify_down(index)
    # Heapify down to maintain heap property
    left = 2 * index + 1
    right = 2 * index + 2
    smallest = index
    
    smallest = left if left < @heap.size && @heap[left] < @heap[smallest]
    smallest = right if right < @heap.size && @heap[right] < @heap[smallest]
    
    return if smallest == index
    
    swap(index, smallest)
    heapify_down(smallest)
  end
  
  def swap(i, j)
    @heap[i], @heap[j] = @heap[j], @heap[i]
  end
end

def min_operations(nums, k)
  # Initialize the min-heap
  heap = MinHeap.new
  
  # Add all elements to the heap
  nums.each { |num| heap.push(num) }

  operations = 0

  # While there are at least two elements and the smallest one is less than k
  while heap.size > 1 && heap.peek < k
    # Pop the two smallest elements
    x = heap.pop
    y = heap.pop
    
    # Calculate the new element
    new_element = x * 2 + y
    
    # Push the new element back to the heap
    heap.push(new_element)
    
    # Increment operation count
    operations += 1
  end

  return operations
end
