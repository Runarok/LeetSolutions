# @param {Integer[]} cards
# @return {Boolean}
def judge_point24(cards)
  # Define a small delta to account for floating-point precision errors.
  # We use this to compare the result to 24 (e.g., 23.9999999999 ≈ 24).
  epsilon = 1e-6

  # This is a recursive helper function that tries all combinations of the numbers
  # and operations to see if we can compute 24.
  def dfs(nums, epsilon)
    # Base case: if only one number is left, check if it's close enough to 24
    return (nums[0] - 24).abs < epsilon if nums.length == 1

    # Try every pair of numbers in the current list
    (0...nums.length).each do |i|
      (0...nums.length).each do |j|
        # Skip if the indices are the same; we need two *different* numbers
        next if i == j

        # Prepare the next set of numbers by removing the two selected numbers
        next_nums = []
        (0...nums.length).each do |k|
          next_nums << nums[k] if k != i && k != j
        end

        # Extract the two numbers to operate on
        a = nums[i]
        b = nums[j]

        # Try all possible binary operations on a and b
        # We must try a + b, a - b, b - a, a * b, a / b, and b / a (if denominator ≠ 0)
        results = []
        results << a + b           # Addition
        results << a - b           # Subtraction (a - b)
        results << b - a           # Subtraction (b - a)
        results << a * b           # Multiplication
        results << a / b if b != 0 # Division (a / b), only if b is not zero
        results << b / a if a != 0 # Division (b / a), only if a is not zero

        # For each result, recurse with the new list including the result
        results.each do |res|
          next_nums << res               # Add the result to the list
          return true if dfs(next_nums, epsilon) # If recursion finds 24, return true
          next_nums.pop                 # Backtrack: remove the result and try next one
        end
      end
    end

    # If no combination gives 24, return false
    false
  end

  # Try all permutations of the input numbers, as the order matters in operations
  # Convert each number to float to allow for division results like 0.5, 1.333, etc.
  cards.permutation.any? { |perm| dfs(perm.map(&:to_f), epsilon) }
end
