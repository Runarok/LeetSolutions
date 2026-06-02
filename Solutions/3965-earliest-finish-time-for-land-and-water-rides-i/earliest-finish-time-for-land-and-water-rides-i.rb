# @param {Integer[]} land_start_time
# @param {Integer[]} land_duration
# @param {Integer[]} water_start_time
# @param {Integer[]} water_duration
# @return {Integer}
def earliest_finish_time(land_start_time, land_duration, water_start_time, water_duration)

  # Store the best (minimum) finish time found so far.
  answer = Float::INFINITY

  # Try every land ride.
  (0...land_start_time.length).each do |i|

    # Try every water ride.
    (0...water_start_time.length).each do |j|

      # ---------------------------------------------------
      # Option 1: Land ride first, then Water ride
      # ---------------------------------------------------

      # Tourist starts the land ride as soon as it opens.
      land_finish = land_start_time[i] + land_duration[i]

      # Water ride can only start:
      #   - after the land ride finishes
      #   - and after the water ride has opened
      water_begin = [land_finish, water_start_time[j]].max

      # Time when both rides are completed in this order.
      finish_land_then_water = water_begin + water_duration[j]

      # Update the global minimum answer.
      answer = [answer, finish_land_then_water].min

      # ---------------------------------------------------
      # Option 2: Water ride first, then Land ride
      # ---------------------------------------------------

      # Tourist starts the water ride as soon as it opens.
      water_finish = water_start_time[j] + water_duration[j]

      # Land ride can only start:
      #   - after the water ride finishes
      #   - and after the land ride has opened
      land_begin = [water_finish, land_start_time[i]].max

      # Time when both rides are completed in this order.
      finish_water_then_land = land_begin + land_duration[i]

      # Update the global minimum answer.
      answer = [answer, finish_water_then_land].min
    end
  end

  # Return the earliest possible finishing time.
  answer
end