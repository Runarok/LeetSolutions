import math  # Import math module to use gcd (greatest common divisor)

class Solution:
    def mirrorReflection(self, p: int, q: int) -> int:
        """
        p: side length of the square room
        q: distance from the 0th receptor where the laser first meets the east wall
        Returns: the receptor number (0, 1, or 2) that the laser meets first
        """

        # Step 1: Find the least common multiple (LCM) of p and q
        # The laser will hit a receptor when it has traveled LCM(p, q) distance vertically
        # LCM can be calculated as (p * q) // gcd(p, q)
        lcm = p * q // math.gcd(p, q)

        # Step 2: Determine how many room widths (m) and heights (n) the laser traveled
        # m = number of horizontal room lengths to reach LCM distance
        # n = number of vertical distances of q to reach LCM distance
        m = lcm // p
        n = lcm // q

        # Step 3: Use parity (odd/even) of m and n to determine which receptor is hit
        # - If m is odd, laser is on the east wall; if even, on the west wall
        # - If n is odd, laser is on the top wall; if even, on the bottom wall
        # Receptor mapping based on problem diagram:
        # - 1: top-right corner (m odd, n odd)
        # - 2: top-left corner (m odd, n even)
        # - 0: bottom-right corner (m even, n odd)
        if m % 2 == 1 and n % 2 == 1:
            return 1
        elif m % 2 == 1 and n % 2 == 0:
            return 2
        else:  # m % 2 == 0 and n % 2 == 1
            return 0
