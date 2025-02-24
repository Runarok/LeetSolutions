from collections import deque

class Solution:
    def __init__(self):
        self.bob_arrival_times = {}  # Store the time at which Bob reaches each node
        self.visited_nodes = []      # List to track visited nodes during BFS
        self.adj_list = []           # Adjacency list to represent the tree

    def mostProfitablePath(self, edges, bob_start, amounts):
        num_nodes = len(amounts)
        max_profit = float("-inf")  # Track the maximum possible profit
        self.adj_list = [[] for _ in range(num_nodes)]  # Initialize the adjacency list
        self.bob_arrival_times = {}  # Reset Bob's arrival times
        self.visited_nodes = [False] * num_nodes  # Reset visited nodes list
        node_queue = deque([(0, 0, 0)])  # Queue for BFS, stores (node, time, current_profit)

        # Build the tree based on the given edges
        for edge in edges:
            self.adj_list[edge[0]].append(edge[1])
            self.adj_list[edge[1]].append(edge[0])

        # Determine the times when Bob arrives at each node
        self.compute_bob_arrival_times(bob_start, 0)

        # Start BFS to explore the tree from Alice's perspective
        self.visited_nodes = [False] * num_nodes
        while node_queue:
            current_node, current_time, current_profit = node_queue.popleft()

            # If Alice reaches this node before Bob
            if current_node not in self.bob_arrival_times or current_time < self.bob_arrival_times[current_node]:
                current_profit += amounts[current_node]
            # If Alice and Bob reach the node at the same time
            elif current_time == self.bob_arrival_times[current_node]:
                current_profit += amounts[current_node] // 2

            # If the current node is a leaf node and not the root, consider it for max profit
            if len(self.adj_list[current_node]) == 1 and current_node != 0:
                max_profit = max(max_profit, current_profit)

            # Explore unvisited adjacent nodes
            for neighbor in self.adj_list[current_node]:
                if not self.visited_nodes[neighbor]:
                    node_queue.append((neighbor, current_time + 1, current_profit))

            # Mark the current node as visited
            self.visited_nodes[current_node] = True

        return max_profit

    def compute_bob_arrival_times(self, current_node, current_time):
        # Mark the current node and set the time when Bob arrives at it
        self.bob_arrival_times[current_node] = current_time
        self.visited_nodes[current_node] = True

        # If Bob has reached node 0, stop the search
        if current_node == 0:
            return True

        # Recursively visit unvisited adjacent nodes
        for neighbor in self.adj_list[current_node]:
            if not self.visited_nodes[neighbor]:
                if self.compute_bob_arrival_times(neighbor, current_time + 1):
                    return True

        # If Bob doesn't reach node 0 from the current path, backtrack by removing the node
        self.bob_arrival_times.pop(current_node, None)
        return False
