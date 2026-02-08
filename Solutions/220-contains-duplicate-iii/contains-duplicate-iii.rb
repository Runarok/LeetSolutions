def contains_nearby_almost_duplicate(nums, index_diff, value_diff)
  # Hash used as buckets:
  # key   -> bucket index
  # value -> the number stored in that bucket
  b = {}

  # Bucket width:
  # We use value_diff + 1 so that:
  # - Any two numbers in the same bucket differ by at most value_diff
  d = value_diff + 1

  # Pointer for iterating through nums
  i = 0

  # Iterate through the array
  while i < nums.length
    num = nums[i]

    # Determine which bucket this number belongs to
    # Integer division groups numbers into ranges of size d
    k = num / d

    # Check three cases:
    # 1. Same bucket -> difference <= value_diff
    # 2. Left neighbor bucket -> may still be within value_diff
    # 3. Right neighbor bucket -> may still be within value_diff
    return true if b[k] ||
      (b[k - 1] && (b[k - 1] - num).abs <= value_diff) ||
      (b[k + 1] && (b[k + 1] - num).abs <= value_diff)

    # Store current number in its bucket
    b[k] = num

    # Maintain sliding window of size index_diff
    # Remove the element that is index_diff positions behind
    # so index difference condition is satisfied
    if index_diff <= i
      old_bucket = nums[i - index_diff] / d
      b.delete(old_bucket)
    end

    # Move to the next index
    i += 1
  end

  # No valid pair found
  false
end
