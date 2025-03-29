class Solution {
public:
    // Modulo value to prevent overflow and ensure results are within range
    const int MOD = 1e9 + 7;

    int maximumScore(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> primeScores(n);

        // Step 1: Calculate the prime score for each number in the nums array
        for (int index = 0; index < n; index++) {
            int num = nums[index];

            // Check for prime factors from 2 to sqrt(num)
            for (int factor = 2; factor <= sqrt(num); factor++) {
                if (num % factor == 0) {
                    // If a factor is found, increment the prime score for this number
                    primeScores[index]++;

                    // Remove all occurrences of this prime factor from num
                    while (num % factor == 0) num /= factor;
                }
            }

            // If num is still greater than or equal to 2, it means it is a prime number
            if (num >= 2) primeScores[index]++;
        }

        // Step 2: Prepare arrays to track the next and previous dominant elements
        vector<int> nextDominant(n, n);   // Next dominant index for each element
        vector<int> prevDominant(n, -1);  // Previous dominant index for each element

        // Stack to keep track of indices while processing in decreasing order of prime scores
        stack<int> decreasingPrimeScoreStack;

        // Step 3: Fill the nextDominant and prevDominant arrays using a monotonic stack
        for (int index = 0; index < n; index++) {
            // While the stack is not empty and the current prime score is greater than
            // the top element in the stack, update the nextDominant for the popped element
            while (!decreasingPrimeScoreStack.empty() &&
                   primeScores[decreasingPrimeScoreStack.top()] < primeScores[index]) {
                int topIndex = decreasingPrimeScoreStack.top();
                decreasingPrimeScoreStack.pop();
                nextDominant[topIndex] = index;  // Set the next dominant index
            }

            // If the stack is not empty, set the previous dominant index for the current index
            if (!decreasingPrimeScoreStack.empty())
                prevDominant[index] = decreasingPrimeScoreStack.top();

            // Push the current index onto the stack
            decreasingPrimeScoreStack.push(index);
        }

        // Step 4: Calculate the number of subarrays where each element is dominant
        vector<long long> numOfSubarrays(n);
        for (int index = 0; index < n; index++) {
            numOfSubarrays[index] = (long long)(nextDominant[index] - index) *
                                    (index - prevDominant[index]);
        }

        // Step 5: Use a priority queue to process elements in decreasing order of their values
        priority_queue<pair<int, int>> processingQueue;
        for (int index = 0; index < n; index++)
            processingQueue.push({nums[index], index});

        long long score = 1;

        // Step 6: Process the elements while there are operations left
        while (k > 0) {
            // Get the element with the maximum value from the queue
            auto [num, index] = processingQueue.top();
            processingQueue.pop();

            // Calculate how many operations can be applied to the current element
            long long operations = min((long long)k, numOfSubarrays[index]);

            // Update the score by raising the element to the power of operations modulo MOD
            score = (score * power(num, operations)) % MOD;

            // Reduce the remaining operations count
            k -= operations;
        }

        // Return the final score after all operations
        return score;
    }

private:
    // Helper function to compute the power of a number modulo MOD using binary exponentiation
    long long power(long long base, long long exponent) {
        long long res = 1;

        // Perform binary exponentiation
        while (exponent > 0) {
            // If the exponent is odd, multiply the result by the base
            if (exponent % 2 == 1) {
                res = ((res * base) % MOD);
            }

            // Square the base and halve the exponent
            base = (base * base) % MOD;
            exponent /= 2;
        }

        return res;
    }
};
