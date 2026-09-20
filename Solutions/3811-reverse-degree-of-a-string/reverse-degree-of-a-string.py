class Solution:
    def reverseDegree(self, s: str) -> int:
        # Initialize total sum to store the reverse degree
        total_reverse_degree = 0

        # Loop through each character in the string along with its 1-based index
        for index, char in enumerate(s, start=1):
            # Calculate 0-based index in the standard alphabet ('a' -> 0, 'b' -> 1, ..., 'z' -> 25)
            alphabet_index = ord(char) - ord("a")

            # Convert to reversed alphabet position ('a' -> 26, 'b' -> 25, ..., 'z' -> 1)
            reversed_alphabet_position = 26 - alphabet_index

            # Multiply reversed alphabet position by its 1-based position in the string
            character_product = reversed_alphabet_position * index

            # Add the calculated product to the running total
            total_reverse_degree += character_product

        # Return the final sum representing the reverse degree of the string
        return total_reverse_degree