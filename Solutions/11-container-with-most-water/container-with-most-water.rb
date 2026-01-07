# @param {Integer[]} height
# @return {Integer}
def max_area(height)
  left = 0                       # start pointer at the beginning
  right = height.length - 1       # end pointer at the last index
  max_area = 0                    # to store the maximum area found

  while left < right
    # Calculate the current container area
    # Width is distance between left and right
    # Height is the smaller of the two heights (cannot slant)
    current_area = [height[left], height[right]].min * (right - left)
    
    # Update max_area if current_area is bigger
    max_area = [max_area, current_area].max

    # Move the pointer pointing to the shorter line
    # Why? Moving the taller line cannot increase area (height is limited by shorter line)
    if height[left] < height[right]
      left += 1
    else
      right -= 1
    end
  end

  max_area                       # return the maximum area found
end
