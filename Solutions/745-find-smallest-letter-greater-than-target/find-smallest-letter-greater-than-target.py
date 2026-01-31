class Solution:
    def nextGreatestLetter(self, letters: List[str], target: str) -> str:
        # We are given a sorted list of characters `letters`
        # and a character `target`.
        # Our goal is to find the smallest character in `letters`
        # that is strictly greater than `target`.
        #
        # If no such character exists (i.e., target >= all letters),
        # we return the first character in the list (wrap-around behavior).

        # Initialize the left pointer for binary search
        left = 0

        # Initialize the right pointer for binary search
        right = len(letters) - 1

        # Default answer is the first letter.
        # This handles the wrap-around case automatically.
        answer = letters[0]

        # Standard binary search loop:
        # Continue while the search space is valid
        while left <= right:
            # Find the middle index of the current search space
            mid = (left + right) // 2

            # If the middle letter is strictly greater than target,
            # it is a valid candidate for the answer
            if letters[mid] > target:
                # Update answer to this letter
                answer = letters[mid]

                # Since we want the *smallest* letter greater than target,
                # we try to find a better candidate on the left side
                right = mid - 1
            else:
                # If letters[mid] is less than or equal to target,
                # it cannot be the answer
                #
                # So we discard the left half including mid
                # and continue searching on the right side
                left = mid + 1

        # After the loop finishes, `answer` holds:
        # - the smallest letter greater than target, OR
        # - letters[0] if no such letter exists
        return answer
