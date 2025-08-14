# The rand7() API is already defined for you.
# def rand7()
# @return {Integer} a random integer in the range 1 to 7

def rand10()
  loop do
    # Generate a uniform integer in [1, 49]
    row = rand7()
    col = rand7()
    index = (row - 1) * 7 + col  # index in range [1, 49]

    # Use only the first 40 values to map to [1, 10]
    if index <= 40
      return 1 + (index - 1) % 10
    end
    # Else retry
  end
end
