# @param {Integer[]} tokens
# @param {Integer} power
# @return {Integer}

# Bag of Tokens
# Maximize score by playing tokens strategically

def bag_of_tokens_score(tokens, power)
  
  # Sort tokens for greedy approach
  tokens.sort!
  
  # Pointers
  i = 0    # smallest token for face-up
  j = tokens.size - 1   # largest token for face-down
  
  # Score trackers
  score = 0
  max_score = 0
  
  # Loop while tokens remain
  while i <= j
    
    # Can play face-up?
    if power >= tokens[i]
      # spend power, gain score
      power -= tokens[i]
      score += 1
      i += 1
      
      # Update max score
      max_score = [max_score, score].max
    
    # Else, can play face-down?
    elsif score >= 1 && i != j
      # spend score, gain power
      power += tokens[j]
      score -= 1
      j -= 1
    
    else
      # No moves left
      break
    end
  end
  
  # Return maximum score achieved
  max_score
end
