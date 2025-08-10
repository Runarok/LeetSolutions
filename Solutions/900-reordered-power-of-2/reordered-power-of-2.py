class Solution:
    def reorderedPowerOf2(self, n: int) -> bool:
        # Helper function to count digits of a number
        def count_digits(x: int) -> str:
            """
            Given an integer x, return a string that represents 
            the count of each digit in sorted order. 
            This helps us compare digit combinations efficiently.
            """
            return ''.join(sorted(str(x)))

        # Get the digit signature of the input number
        n_count = count_digits(n)

        # Check all powers of 2 up to 10^9 (since n <= 10^9)
        # Start with 2^0 = 1 and go up to 2^30 = 1073741824
        # because 2^31 = 2147483648 > 10^9
        for i in range(31):
            power_of_two = 1 << i  # same as 2 ** i
            # Get the digit signature of the power of two
            power_count = count_digits(power_of_two)

            # If the sorted digits of n match sorted digits of any power of 2
            if n_count == power_count:
                return True  # Found a match

        # If none of the powers of 2 matched
        return False
