from typing import List
from collections import Counter

class Solution:
    def maxFrequencyElements(self, nums: List[int]) -> int:
        # Step 1: Count the frequency of each element in the list using Counter
        freq_map = Counter(nums)
        # Example: nums = [1,2,2,3,1,4] => freq_map = {1: 2, 2: 2, 3: 1, 4: 1}

        # Step 2: Find the maximum frequency among all elements
        max_freq = max(freq_map.values())
        # In the example above, max_freq = 2

        # Step 3: Sum the frequencies of all elements that occur with the maximum frequency
        # We go through each frequency, and if it equals max_freq, we add it to the total
        total = sum(freq for freq in freq_map.values() if freq == max_freq)
        # In the example: 1 and 2 both have freq 2 => total = 2 + 2 = 4

        # Step 4: Return the total count of elements with maximum frequency
        return total
