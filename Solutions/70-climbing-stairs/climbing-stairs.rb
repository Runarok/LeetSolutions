# @param {Integer} n
# @return {Integer}
def climb_stairs(n)
  return 1 if n == 1       # Only 1 way to climb 1 step
  return 2 if n == 2       # Two ways to climb 2 steps: 1+1 or 2

  # Initialize the first two steps
  one_step_before = 2      # ways to reach step 2
  two_steps_before = 1     # ways to reach step 1

  current = 0

  # Compute ways for steps 3 to n
  (3..n).each do |i|
    current = one_step_before + two_steps_before  # Fibonacci recurrence
    two_steps_before = one_step_before           # shift for next iteration
    one_step_before = current
  end

  current
end
