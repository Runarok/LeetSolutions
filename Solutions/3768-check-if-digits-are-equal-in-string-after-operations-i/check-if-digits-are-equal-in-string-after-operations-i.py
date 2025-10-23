class Solution:
    def hasSameDigits(self, s: str) -> bool:
        """
        Determines if after repeatedly replacing the string `s` of digits
        with a new string formed by taking (digit[i] + digit[i+1]) % 10 
        until two digits remain, those final two digits are the same.

        Args:
            s (str): Input string consisting of digits.

        Returns:
            bool: True if the final two digits are the same, otherwise False.
        """

        # Continue performing the operation until only two digits remain
        while len(s) > 2:
            new_s = []  # This will store the new sequence of digits after one iteration
            
            # Iterate through consecutive pairs of digits
            for i in range(len(s) - 1):
                # Convert both characters to integers
                first_digit = int(s[i])
                second_digit = int(s[i + 1])

                # Compute the sum modulo 10 (as per the problem description)
                new_digit = (first_digit + second_digit) % 10

                # Append the new digit (as a string) to the result list
                new_s.append(str(new_digit))

            # Convert the list of new digits back to a string for the next iteration
            s = ''.join(new_s)
            
            # Debugging/logging line (optional): print intermediate results
            # print(f"After iteration: {s}")

        # When we exit the loop, s has exactly two digits.
        # Check if both digits are the same
        return s[0] == s[1]
