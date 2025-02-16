from typing import List

class Solution:
    def constructDistancedSequence(self, target_number: int) -> List[int]:
        # Initialize the result sequence with size 2*n - 1, filled with zeros.
        # This will be our final sequence that we need to construct.
        result_sequence = [0] * (target_number * 2 - 1)

        # Keep track of which numbers have already been placed in the sequence.
        # The 'is_number_used' array marks whether a number has been placed or not.
        is_number_used = [False] * (target_number + 1)

        # Start the recursive backtracking process to construct the lexicographically largest valid sequence.
        # Begin by trying to fill the sequence starting from index 0.
        self.find_lexicographically_largest_sequence(
            0, result_sequence, is_number_used, target_number
        )

        # Return the sequence once it is fully constructed.
        return result_sequence

    def find_lexicographically_largest_sequence(
        self, current_index, result_sequence, is_number_used, target_number
    ):
        # Base Case: If we have filled all positions in the sequence, it means the sequence is valid.
        # We return True to indicate that we've successfully constructed the sequence.
        if current_index == len(result_sequence):
            return True

        # If the current index is already filled, we simply move to the next index.
        # This prevents overwriting existing numbers.
        if result_sequence[current_index] != 0:
            return self.find_lexicographically_largest_sequence(
                current_index + 1,  # Move to the next index
                result_sequence,
                is_number_used,
                target_number,
            )

        # Try placing each number from 'target_number' down to 1 to get the lexicographically largest result.
        for number_to_place in range(target_number, 0, -1):
            # Skip the number if it has already been used (i.e., already placed in the sequence).
            if is_number_used[number_to_place]:
                continue

            # Mark the number as used and place it at the current index.
            is_number_used[number_to_place] = True
            result_sequence[current_index] = number_to_place

            # If we are placing number 1, we can directly move to the next index.
            # Number 1 is the simplest, as it doesn't require a second occurrence.
            if number_to_place == 1:
                if self.find_lexicographically_largest_sequence(
                    current_index + 1,  # Move to the next index
                    result_sequence,
                    is_number_used,
                    target_number,
                ):
                    return True

            # For larger numbers (2 to n), we need to place them at two indices: 
            # The current index and the index `current_index + number_to_place`.
            # We need to ensure that the second position is empty before placing the number.
            elif (
                current_index + number_to_place < len(result_sequence)  # Check if the second position is valid
                and result_sequence[current_index + number_to_place] == 0  # Ensure it's empty
            ):
                result_sequence[current_index + number_to_place] = number_to_place

                # Recursively try to place the next number by moving to the next index.
                if self.find_lexicographically_largest_sequence(
                    current_index + 1,  # Move to the next index
                    result_sequence,
                    is_number_used,
                    target_number,
                ):
                    return True

                # If the placement didn't work, we backtrack:
                # Undo the placement of number_to_place at the second index.
                result_sequence[current_index + number_to_place] = 0

            # Backtrack: Undo the current placement and mark the number as unused
            result_sequence[current_index] = 0
            is_number_used[number_to_place] = False

        # If no valid placement was found for the current index, return False to backtrack.
        return False
