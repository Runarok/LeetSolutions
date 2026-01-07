# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Float}
def find_median_sorted_arrays(nums1, nums2)
  # Make sure nums1 is the smaller array to minimize binary search range
  if nums1.size > nums2.size
    nums1, nums2 = nums2, nums1
  end

  m, n = nums1.size, nums2.size
  imin, imax = 0, m
  half_len = (m + n + 1) / 2   # Half of total length, +1 to handle odd lengths

  while imin <= imax
    i = (imin + imax) / 2       # Partition index for nums1
    j = half_len - i             # Corresponding partition index for nums2

    # i is too small, must move right
    if i < m && nums2[j-1] > nums1[i]
      imin = i + 1

    # i is too big, must move left
    elsif i > 0 && nums1[i-1] > nums2[j]
      imax = i - 1

    # i is perfect
    else
      # Find max of left partition
      max_of_left = if i == 0
                      nums2[j-1]
                    elsif j == 0
                      nums1[i-1]
                    else
                      [nums1[i-1], nums2[j-1]].max
                    end

      # If total length is odd, median is max of left
      if (m + n).odd?
        return max_of_left.to_f
      end

      # Find min of right partition
      min_of_right = if i == m
                       nums2[j]
                     elsif j == n
                       nums1[i]
                     else
                       [nums1[i], nums2[j]].min
                     end

      # If total length is even, median is average of max_of_left and min_of_right
      return (max_of_left + min_of_right) / 2.0
    end
  end
end
