# @param {Integer[]} bills
# @return {Boolean}
def lemonade_change(bills)
  five = 0   # count of $5 bills in hand
  ten  = 0   # count of $10 bills in hand

  bills.each do |bill|
    case bill
    when 5
      five += 1               # take $5, no change needed
    when 10
      return false if five == 0
      five -= 1               # give $5 as change
      ten += 1                # receive $10
    when 20
      # prefer giving $10 + $5 as change
      if ten > 0 && five > 0
        ten -= 1
        five -= 1
      elsif five >= 3          # otherwise give 3x $5
        five -= 3
      else
        return false
      end
    end
  end

  true
end
