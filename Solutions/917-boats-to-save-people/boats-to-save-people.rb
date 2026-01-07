# @param {Integer[]} people
# @param {Integer} limit
# @return {Integer}
def num_rescue_boats(people, limit)
  people.sort!  # Sort weights
  i, j = 0, people.length - 1
  boats = 0

  while i <= j
    if people[i] + people[j] <= limit
      i += 1  # lightest person joins
    end
    j -= 1    # heaviest person always goes
    boats += 1
  end

  boats
end
