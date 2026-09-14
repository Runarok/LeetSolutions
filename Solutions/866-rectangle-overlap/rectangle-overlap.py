class Solution:
    def isRectangleOverlap(self, rec1: list[int], rec2: list[int]) -> bool:
        # rec1 = [x1, y1, x2, y2]
        # rec2 = [x1, y1, x2, y2]
        #
        # For each rectangle:
        # x1 = left edge
        # y1 = bottom edge
        # x2 = right edge
        # y2 = top edge
        
        # Extract the coordinates of the first rectangle.
        x1_1, y1_1, x2_1, y2_1 = rec1
        
        # Extract the coordinates of the second rectangle.
        x1_2, y1_2, x2_2, y2_2 = rec2
        
        # ---------------------------------------------------------
        # Check if there is horizontal overlap.
        # ---------------------------------------------------------
        #
        # The overlapping part on the X-axis must have
        # positive width.
        #
        # The left edge of the overlap is the larger of
        # the two left edges.
        #
        # The right edge of the overlap is the smaller of
        # the two right edges.
        #
        # So:
        #
        #   overlap_width = min(x2_1, x2_2) - max(x1_1, x1_2)
        #
        # We need this to be > 0.
        #
        # If it is 0, the rectangles only touch along an edge,
        # so they DO NOT overlap.
        
        horizontal_overlap = min(x2_1, x2_2) - max(x1_1, x1_2)
        
        # ---------------------------------------------------------
        # Check if there is vertical overlap.
        # ---------------------------------------------------------
        #
        # Similarly, the overlapping part on the Y-axis must
        # have positive height.
        #
        #   overlap_height = min(y2_1, y2_2) - max(y1_1, y1_2)
        #
        # Again, this must be > 0.
        
        vertical_overlap = min(y2_1, y2_2) - max(y1_1, y1_2)
        
        # ---------------------------------------------------------
        # For the rectangles to have a positive-area intersection:
        #
        #   width  > 0
        #   height > 0
        #
        # If both are positive, the rectangles overlap.
        #
        # If either one is 0, they only touch.
        #
        # If either one is negative, they are separated.
        # ---------------------------------------------------------
        
        return horizontal_overlap > 0 and vertical_overlap > 0
