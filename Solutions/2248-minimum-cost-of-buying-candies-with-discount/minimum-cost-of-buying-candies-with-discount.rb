# @param {Integer[]} cost
# @return {Integer}
def minimum_cost(cost)
  # Sort candies from highest cost to lowest cost.
  # This allows us to maximize the value of candies we get for free.
  cost.sort!.reverse!

  # Variable to store the total amount we need to pay.
  total = 0

  # Iterate through the sorted array.
  # We process candies in groups of 3:
  # - Pay for the first two candies.
  # - The third candy is free.
  i = 0

  while i < cost.length
    # Always pay for the first candy in the group.
    total += cost[i]

    # Pay for the second candy if it exists.
    total += cost[i + 1] if i + 1 < cost.length

    # Skip the third candy because it is free.
    # Move to the next group of three candies.
    i += 3
  end

  # Return the minimum total cost.
  total
end