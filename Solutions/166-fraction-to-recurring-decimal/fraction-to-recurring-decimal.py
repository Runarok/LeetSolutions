class Solution:
    def fractionToDecimal(self, numerator: int, denominator: int) -> str:
        # If numerator is 0, the result is "0" regardless of the denominator
        if numerator == 0:
            return "0"
        
        result = []

        # If the result is negative, add '-' to the result
        if (numerator < 0) ^ (denominator < 0):
            result.append('-')

        # Work with absolute values to simplify the logic
        numerator = abs(numerator)
        denominator = abs(denominator)

        # Integer part of the division
        integer_part = numerator // denominator
        result.append(str(integer_part))

        # Get the initial remainder
        remainder = numerator % denominator

        # If there is no remainder, return the integer part as result
        if remainder == 0:
            return ''.join(result)

        # Otherwise, there is a fractional part
        result.append('.')

        # Dictionary to store the position of each remainder
        remainder_map = {}

        # Start long division
        while remainder != 0:
            # If we have seen this remainder before, we found a repeating cycle
            if remainder in remainder_map:
                # Insert '(' at the position where the repeating part starts
                start_index = remainder_map[remainder]
                result.insert(start_index, '(')
                result.append(')')
                break

            # Store the position of this remainder
            remainder_map[remainder] = len(result)

            # Multiply the remainder by 10 for the next digit
            remainder *= 10

            # Get the next digit
            digit = remainder // denominator
            result.append(str(digit))

            # Update the remainder
            remainder %= denominator

        return ''.join(result)
