# @param {Integer[][]} points
# @return {Integer}
def min_time_to_visit_all_points(points)
    # This will store the total time required
    total_time = 0

    # We start from the second point and compare it with the previous one
    # because time is spent moving between consecutive points
    (1...points.length).each do |i|
        # Current point coordinates
        x1, y1 = points[i - 1]
        
        # Next point coordinates
        x2, y2 = points[i]

        # Absolute difference in x-direction
        dx = (x2 - x1).abs
        
        # Absolute difference in y-direction
        dy = (y2 - y1).abs

        # Since diagonal moves are allowed,
        # the minimum time to move between two points
        # is the maximum of dx and dy
        total_time += [dx, dy].max
    end

    # Return the accumulated total time
    total_time
end
