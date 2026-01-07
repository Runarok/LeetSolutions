# @param {Integer[][]} points
# @return {Integer}

# Function to compute Manhattan distance between two points
def manhattan(p1, p2)
    (p1[0] - p2[0]).abs + (p1[1] - p2[1]).abs
end

# Main function
def min_cost_connect_points(points)
    n = points.length
    # Track if a point is already included in MST
    in_mst = Array.new(n, false)
    # min_dist[i] = minimum distance from point i to current MST
    min_dist = Array.new(n, Float::INFINITY)
    
    # Start from point 0
    min_dist[0] = 0
    total_cost = 0

    n.times do
        # Find the next point u not in MST with the smallest min_dist
        u = -1
        (0...n).each do |i|
            if !in_mst[i] && (u == -1 || min_dist[i] < min_dist[u])
                u = i
            end
        end

        # Add point u to MST
        in_mst[u] = true
        total_cost += min_dist[u]

        # Update min_dist for remaining points
        (0...n).each do |v|
            next if in_mst[v]
            dist = manhattan(points[u], points[v])
            min_dist[v] = [min_dist[v], dist].min
        end
    end

    total_cost
end
