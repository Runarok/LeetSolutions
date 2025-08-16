# @param {Integer} num
# @return {Integer}
def maximum69_number(num)
  # Convert the number to a string so we can manipulate its digits
  num_str = num.to_s
  
  # Check if there is any '6' in the number
  if num_str.include?('6')
    # Replace only the first occurrence of '6' with '9' to maximize the number
    num_str.sub!('6', '9')
  end
  
  # Convert the modified string back to an integer and return it
  num_str.to_i
end
