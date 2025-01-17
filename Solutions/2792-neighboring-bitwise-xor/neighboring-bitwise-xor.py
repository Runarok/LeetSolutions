from typing import List

class Solution:
    def doesValidArrayExist(self, derived: List[int]) -> bool:
        n = len(derived)

        # Helper function to check if an array can be valid starting with original[0] = start
        def checkOriginalStartingWith(start: int) -> bool:
            original = [0] * n
            original[0] = start
            
            # Compute the rest of the array based on derived
            for i in range(1, n):
                original[i] = derived[i - 1] ^ original[i - 1]
            
            # Check the circular condition for the last element
            return (original[n - 1] ^ original[0]) == derived[n - 1]
        
        # Try both possible values for original[0] (0 or 1)
        return checkOriginalStartingWith(0) or checkOriginalStartingWith(1)
