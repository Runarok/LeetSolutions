int q[50000], front=0, back=0;  // Queue to store tasks and pointers to track front and back

class Solution {
public:
    int n, m, strength;  // n = number of tasks, m = number of workers, strength = worker's strength

    // Function to check if it is doable to assign tasks with a given number of workers (k) and pills
    bool doable(vector<int>& tasks, vector<int>& workers, int k, int pills){
        int t_idx=0;  // Task index
        front=back=0;  // Reset the front and back pointers for the queue
        
        // Loop through the workers starting from the m-k-th worker (the strongest ones)
        for (int i=m-k; i<m; i++){
            int W = workers[i];  // Current worker's strength
            
            // Assign tasks that the current worker can complete without a pill
            // The task must not exceed the worker's strength + strength threshold
            for(; t_idx<k && tasks[t_idx]<=W+strength; t_idx++) 
                q[back++] = tasks[t_idx];  // Add the task to the queue

            // If no tasks left to assign, return false (no tasks to assign)
            if (front == back) return 0;

            // If the task at the front of the queue can be completed by the worker, no pill needed
            if (q[front] <= W) front++;  // Move the front pointer

            // Otherwise, try to use a pill on the hardest task (the one at the back)
            else{
                if (pills == 0) return 0;  // No pills left to use
                pills--;  // Use one pill
                back--;  // Remove the hardest task (the last task in the queue)
            }
        }
        return 1;  // All workers have been assigned tasks successfully
    }

    // Main function to find the maximum number of tasks that can be assigned
    int maxTaskAssign(vector<int>& tasks, vector<int>& workers, int pills, int strength) {
        n = tasks.size();  // Number of tasks
        m = workers.size();  // Number of workers
        this->strength = strength;  // Store the strength for later use
        
        sort(tasks.begin(), tasks.end());  // Sort tasks in ascending order
        sort(workers.begin(), workers.end());  // Sort workers in ascending order

        int l = 0, r = min(n, m);  // Initialize binary search bounds: l = 0, r = minimum of tasks or workers

        // Perform binary search to find the maximum number of tasks that can be assigned
        while (l < r) {
            int mid = (l + r + 1) / 2;  // Find the middle value for binary search
            
            // If it's possible to assign 'mid' tasks, search in the upper half
            if (doable(tasks, workers, mid, pills))
                l = mid;
            else
                r = mid - 1;  // If not possible, search in the lower half
        }

        return l;  // Return the maximum number of tasks that can be assigned
    }
};
