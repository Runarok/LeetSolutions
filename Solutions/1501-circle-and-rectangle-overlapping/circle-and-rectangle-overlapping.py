class Solution:
    def checkOverlap(
        self,
        radius: int,
        xCenter: int,
        yCenter: int,
        x1: int,
        y1: int,
        x2: int,
        y2: int,
    ) -> bool:
        # Step 1: Find the x-coordinate on the rectangle closest to the circle's center.
        # We clamp xCenter to be within the bounds [x1, x2].
        closest_x = max(x1, min(xCenter, x2))

        # Step 2: Find the y-coordinate on the rectangle closest to the circle's center.
        # We clamp yCenter to be within the bounds [y1, y2].
        closest_y = max(y1, min(yCenter, y2))

        # Step 3: Compute the horizontal and vertical distances from the center to the closest point.
        dist_x = xCenter - closest_x
        dist_y = yCenter - closest_y

        # Step 4: Calculate the squared distance using the Pythagorean theorem.
        # Using squared values avoids precision loss from floating-point square root operations.
        distance_squared = (dist_x * dist_x) + (dist_y * dist_y)

        # Step 5: Check if the closest point lies inside or on the boundary of the circle.
        # Overlap occurs if distance_squared <= radius^2.
        return distance_squared <= radius * radius