use std::collections::VecDeque;

impl Solution {
    pub fn can_finish(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> bool {

        let n = num_courses as usize;

        // Step 1: Build adjacency list
        // graph[b] = list of courses dependent on b
        let mut graph = vec![Vec::new(); n];

        // Step 2: Indegree array
        // indegree[i] = number of prerequisites for course i
        let mut indegree = vec![0; n];

        for pair in prerequisites {
            let course = pair[0] as usize;
            let prereq = pair[1] as usize;

            graph[prereq].push(course);
            indegree[course] += 1;
        }

        // Step 3: Queue for BFS
        let mut queue = VecDeque::new();

        // Add all courses with no prerequisites
        for i in 0..n {
            if indegree[i] == 0 {
                queue.push_back(i);
            }
        }

        // Count how many courses we can "take"
        let mut completed = 0;

        // Step 4: BFS (Topological Sort)
        while let Some(curr) = queue.pop_front() {

            completed += 1;

            // Reduce indegree of neighbors
            for &next in &graph[curr] {
                indegree[next] -= 1;

                // If no prerequisites left, add to queue
                if indegree[next] == 0 {
                    queue.push_back(next);
                }
            }
        }

        // Step 5: Check if all courses are completed
        completed == n
    }
}