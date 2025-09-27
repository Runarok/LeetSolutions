from typing import List  # For type hinting
import itertools         # To generate combinations of 3 points easily

class Solution:
    def largestTriangleArea(self, points: List[List[int]]) -> float:
        
        # Helper function to compute the area of a triangle using three points
        def triangle_area(p1, p2, p3):
            # Unpack each point into x and y coordinates
            x1, y1 = p1
            x2, y2 = p2
            x3, y3 = p3

            # Use the Shoelace formula to compute the area of the triangle
            # Formula: 0.5 * |x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2)|
            return abs(x1 * (y2 - y3) + 
                       x2 * (y3 - y1) + 
                       x3 * (y1 - y2)) / 2

        # Initialize the maximum area found so far to 0
        max_area = 0.0

        # Generate all unique combinations of 3 different points
        for p1, p2, p3 in itertools.combinations(points, 3):
            # Calculate the area of the triangle formed by p1, p2, and p3
            area = triangle_area(p1, p2, p3)

            # Update max_area if this triangle's area is larger
            max_area = max(max_area, area)

        # Return the maximum area found
        return max_area
