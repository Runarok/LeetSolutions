# @param {Integer} n
# @param {Integer[][]} reserved_seats
# @return {Integer}
def max_number_of_families(n, reserved_seats)
  # Step 1: Map rows -> set of reserved seats
  rows = Hash.new { |h, k| h[k] = Set.new }

  reserved_seats.each do |row, seat|
    rows[row].add(seat)
  end

  # Step 2: Start with all completely empty rows
  # Each empty row can fit 2 groups
  total = (n - rows.size) * 2

  # Step 3: Process rows that have reservations
  rows.each do |row, seats|
    
    # Check if left block [2,3,4,5] is free
    left_free = !(seats.include?(2) || seats.include?(3) ||
                  seats.include?(4) || seats.include?(5))

    # Check if right block [6,7,8,9] is free
    right_free = !(seats.include?(6) || seats.include?(7) ||
                   seats.include?(8) || seats.include?(9))

    # Check middle block [4,5,6,7]
    middle_free = !(seats.include?(4) || seats.include?(5) ||
                    seats.include?(6) || seats.include?(7))

    if left_free && right_free
      # Can place 2 groups
      total += 2
    elsif left_free || right_free || middle_free
      # Can place at least 1 group
      total += 1
    end
  end

  return total
end