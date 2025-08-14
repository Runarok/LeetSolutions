# @param {Integer} n
# @return {Float}
def nth_person_gets_nth_seat(n)
  # If there's only one person, they must sit in their own seat
  return 1.0 if n == 1

  # For n >= 2, the probability converges to 0.5
  return 0.5
end
