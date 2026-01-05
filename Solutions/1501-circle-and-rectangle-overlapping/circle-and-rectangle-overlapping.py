class Solution:
    def checkOverlap(self, radius: int, xCenter: int, yCenter: int, 
                     x1: int, y1: int, x2: int, y2: int) -> bool:
        """
        radius: radius of the circle
        (xCenter, yCenter): center of the circle
        (x1, y1): bottom-left corner of rectangle
        (x2, y2): top-right corner of rectangle
        Returns True if circle and rectangle overlap, False otherwise
        """

        # Step 1: Find the closest point on the rectangle to the circle center
        # Clamp the x-coordinate of the circle center between x1 and x2
        # This ensures the point lies on the rectangle's boundary or inside
        closestX = max(x1, min(xCenter, x2))

        # Clamp the y-coordinate of the circle center between y1 and y2
        closestY = max(y1, min(yCenter, y2))

        # Step 2: Compute the distance squared between the circle center and this closest point
        # distance_squared = (dx)^2 + (dy)^2
        # This avoids using square root which is unnecessary for comparison
        dx = closestX - xCenter
        dy = closestY - yCenter
        distance_squared = dx * dx + dy * dy

        # Step 3: Compare distance squared with radius squared
        # If distance squared <= radius squared, circle overlaps rectangle
        return distance_squared <= radius * radius
