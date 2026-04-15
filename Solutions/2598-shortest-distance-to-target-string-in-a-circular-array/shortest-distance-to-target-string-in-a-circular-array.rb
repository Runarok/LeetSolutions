# @param {String[]} words
# @param {String} target
# @param {Integer} start_index
# @return {Integer}
def closest_target(words, target, start_index)
  n = words.length
  
  # Initialize result with a large number
  min_distance = Float::INFINITY
  
  # Iterate through all indices in the array
  (0...n).each do |i|
    
    # Check if current word matches the target
    if words[i] == target
      
      # Distance if we move forward (clockwise)
      forward_steps = (i - start_index) % n
      
      # Distance if we move backward (counter-clockwise)
      backward_steps = (start_index - i) % n
      
      # Take the smaller of the two directions
      current_distance = [forward_steps, backward_steps].min
      
      # Update the minimum distance found so far
      min_distance = [min_distance, current_distance].min
    end
  end
  
  # If we never found the target, return -1
  return -1 if min_distance == Float::INFINITY
  
  # Otherwise, return the shortest distance
  min_distance
end