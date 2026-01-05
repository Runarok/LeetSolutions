# Function to count the total number of digit 1 in all numbers from 0 to n
# @param {Integer} n - the upper limit
# @return {Integer} - total count of digit 1
def count_digit_one(n)
  # Initialize result to 0
  total_ones = 0

  # Start with the ones place (position = 1)
  # We will go through each digit position: ones, tens, hundreds, ...
  position = 1

  # Loop until we have processed all digits
  while position <= n
    # For the current position:
    # - divide n into three parts: higher digits, current digit, lower digits
    higher = n / (position * 10)     # digits higher than current position
    current = (n / position) % 10    # digit at current position
    lower = n % position              # digits lower than current position

    # Count how many 1s appear at this position
    # There are three cases depending on current digit:
    if current == 0
      # If current digit is 0:
      # the number of 1s contributed by this position is:
      # higher * position
      total_ones += higher * position
    elsif current == 1
      # If current digit is 1:
      # contribution = higher * position + lower + 1
      # lower + 1 accounts for the numbers from ...10... to ...1...n
      total_ones += higher * position + (lower + 1)
    else
      # If current digit > 1:
      # contribution = (higher + 1) * position
      # Because all numbers with this digit position being 1 appear once every full cycle
      total_ones += (higher + 1) * position
    end

    # Move to the next higher position
    position *= 10
  end

  return total_ones
end
