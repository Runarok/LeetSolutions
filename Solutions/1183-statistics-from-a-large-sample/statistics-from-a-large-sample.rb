# @param {Integer[]} count
# @return {Float[]}
def sample_stats(count)
  # Total number of elements in the sample
  total = 0

  # Sum of all values (used to compute mean)
  sum = 0.0

  # Minimum and maximum values in the sample
  min_val = nil
  max_val = nil

  # Mode-related tracking
  mode_val = 0       # The value with the highest frequency
  max_count = 0      # The frequency of the mode value

  # --------------------------------------------------------
  # Step 1: Single Pass to calculate:
  #   - min and max values
  #   - total count of numbers
  #   - sum of values (for mean)
  #   - mode value (highest frequency)
  # --------------------------------------------------------
  count.each_with_index do |freq, val|
    next if freq == 0  # Skip values not present in sample

    # Set the minimum value (first non-zero frequency)
    min_val ||= val

    # Update maximum as we move through the array
    max_val = val

    # Update total count and sum of all numbers
    total += freq
    sum += val * freq

    # Update mode if this value has higher frequency than current max
    if freq > max_count
      max_count = freq
      mode_val = val
    end
  end

  # --------------------------------------------------------
  # Step 2: Determine the median
  # The median depends on whether the sample has an even or odd size
  # --------------------------------------------------------

  # For odd sample size: median is the middle element
  # For even sample size: median is the average of the two middle elements
  if total % 2 == 0
    mid1 = total / 2         # First middle position (1-based index)
    mid2 = mid1 + 1          # Second middle position
  else
    mid1 = mid2 = (total + 1) / 2  # Single middle position
  end

  # Cumulative count to track current position in sorted sample
  cumulative = 0

  # Variables to store the two median elements (they could be the same)
  median1 = nil
  median2 = nil

  # --------------------------------------------------------
  # Step 3: Iterate to find the values at positions mid1 and mid2
  # This is equivalent to selecting the (mid1)th and (mid2)th numbers
  # in the sorted flattened version of the sample.
  # --------------------------------------------------------
  (0..255).each do |val|
    cumulative += count[val]

    # Find the first median value (lower middle)
    if median1.nil? && cumulative >= mid1
      median1 = val
    end

    # Find the second median value (upper middle)
    if median2.nil? && cumulative >= mid2
      median2 = val
      break  # No need to continue once both medians are found
    end
  end

  # Final median is the average of the two found values
  median = (median1 + median2) / 2.0

  # --------------------------------------------------------
  # Step 4: Calculate mean
  # Mean = total sum of all values / number of values
  # --------------------------------------------------------
  mean = sum / total

  # --------------------------------------------------------
  # Step 5: Return the final statistics
  # Convert everything to float for precision
  # Format: [min, max, mean, median, mode]
  # --------------------------------------------------------
  [
    min_val.to_f,
    max_val.to_f,
    mean,
    median,
    mode_val.to_f
  ]
end
