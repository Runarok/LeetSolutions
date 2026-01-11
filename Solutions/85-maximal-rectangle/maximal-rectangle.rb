# We are given a binary matrix of characters '0' and '1'
# Our goal is to find the area of the largest rectangle containing only '1's

def maximal_rectangle(matrix)
  # Edge case: empty matrix
  return 0 if matrix.nil? || matrix.empty? || matrix[0].empty?

  rows = matrix.length
  cols = matrix[0].length

  # This array will store the "height" of consecutive 1's for each column
  # Think of it as a histogram that we build row by row
  heights = Array.new(cols, 0)

  # This will store the maximum rectangle area found so far
  max_area = 0

  # Iterate over each row of the matrix
  (0...rows).each do |r|
    # Update the histogram heights for this row
    (0...cols).each do |c|
      if matrix[r][c] == '1'
        # If current cell is '1', increase height
        heights[c] += 1
      else
        # If current cell is '0', reset height to 0
        heights[c] = 0
      end
    end

    # After updating heights, compute the largest rectangle
    # in the histogram represented by heights[]
    max_area = [max_area, largest_rectangle_area(heights)].max
  end

  max_area
end

# Helper function to compute the largest rectangle in a histogram
# This uses a monotonic increasing stack
def largest_rectangle_area(heights)
  # Stack will store indices of the histogram bars
  stack = []

  max_area = 0

  # We append a 0 at the end to force processing of all bars
  extended_heights = heights + [0]

  extended_heights.each_with_index do |h, i|
    # While the current height is less than the height
    # at the top of the stack, we can form rectangles
    while !stack.empty? && h < extended_heights[stack[-1]]
      # Height of the rectangle is the height of the popped bar
      height = extended_heights[stack.pop]

      # Width calculation:
      # If stack is empty, rectangle spans from index 0 to i-1
      # Otherwise, spans from stack[-1] + 1 to i - 1
      width = stack.empty? ? i : i - stack[-1] - 1

      # Update maximum area
      max_area = [max_area, height * width].max
    end

    # Push current index onto the stack
    stack << i
  end

  max_area
end
