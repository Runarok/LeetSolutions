# @param {Integer} n
# @param {Integer[][]} edges
# @return {Integer[][]}

# Union-Find (Disjoint Set Union) data structure
class UnionFind
    # Initialize n nodes
    def initialize(n)
        # parent[i] represents the parent of node i
        @parent = (0...n).to_a
        # rank[i] helps to optimize union operations (union by rank)
        @rank = Array.new(n, 0)
    end
    
    # Find the root of node x with path compression
    def find(x)
        # If x is not its own parent, recursively find root and compress path
        if @parent[x] != x
            @parent[x] = find(@parent[x])
        end
        # Return the root of x
        @parent[x]
    end
    
    # Union two nodes x and y
    # Returns true if union was successful (they were not connected)
    # Returns false if x and y are already in the same set
    def union(x, y)
        # Find roots of x and y
        xr, yr = find(x), find(y)
        # If roots are same, already connected, cannot union
        return false if xr == yr
        
        # Union by rank: attach smaller rank tree under larger rank tree
        if @rank[xr] < @rank[yr]
            @parent[xr] = yr
        elsif @rank[xr] > @rank[yr]
            @parent[yr] = xr
        else
            # Same rank: attach yr under xr and increment rank
            @parent[yr] = xr
            @rank[xr] += 1
        end
        
        # Union successful
        true
    end
end

# Function to compute MST weight using Kruskal's algorithm
# Optionally include or exclude a specific edge
def kruskal(n, edges, include_edge = nil, exclude_edge = nil)
    # Initialize union-find for n nodes
    uf = UnionFind.new(n)
    
    # Total weight of MST
    weight = 0
    
    # If an edge must be included in MST first
    if include_edge
        # Add its weight
        weight += include_edge[2]
        # Union its two nodes
        uf.union(include_edge[0], include_edge[1])
    end
    
    # Process all edges in sorted order (edges already sorted by weight)
    edges.each do |u, v, w, idx|
        # Skip this edge if it should be excluded
        next if exclude_edge && idx == exclude_edge[3]
        # Skip this edge if it was already included
        next if include_edge && idx == include_edge[3]
        
        # Try to union the nodes, add weight if union succeeds
        weight += w if uf.union(u, v)
    end
    
    # Check if all nodes are connected (MST is valid)
    uf_count = (0...n).map { |i| uf.find(i) }.uniq.size
    
    # If all nodes connected, return total MST weight; else return infinity
    uf_count == 1 ? weight : Float::INFINITY
end

# Main function to find critical and pseudo-critical edges
def find_critical_and_pseudo_critical_edges(n, edges)
    # Add original index to each edge for later identification
    edges.each_with_index { |e, i| e << i }
    
    # Sort edges by weight ascending
    edges.sort_by! { |e| e[2] }
    
    # Compute MST weight normally without forcing or excluding edges
    mst_weight = kruskal(n, edges)
    
    # Arrays to hold edge indices
    critical = []          # edges that appear in all MSTs
    pseudo_critical = []   # edges that appear in some MSTs
    
    # Check each edge
    edges.each do |edge|
        # Case 1: Critical edge
        # Remove edge and compute MST weight
        # If MST weight increases, edge is critical
        if kruskal(n, edges, nil, edge) > mst_weight
            critical << edge[3]
        # Case 2: Pseudo-critical edge
        # Include edge first and compute MST weight
        # If MST weight equals original MST, edge is pseudo-critical
        elsif kruskal(n, edges, edge) == mst_weight
            pseudo_critical << edge[3]
        end
    end
    
    # Return two arrays: [critical edges, pseudo-critical edges]
    [critical, pseudo_critical]
end
