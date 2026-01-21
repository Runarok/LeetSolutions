using ll = long long;                 // Alias for long long to simplify typing
const ll NINF = (ll)-1e50;            // A very large negative number, used as "negative infinity"

// Solution class
class Solution {
private:
    // Core DP solver for a **linear array**, not cyclic
    ll solve(const vector<int>& A, int K) {
        int N = (int)A.size();        // Number of elements in the array

        // Precompute W[i][j] = range (max - min) of subarray A[i..j]
        vector<vector<int>> W(N, vector<int>(N, 0));
        for (int i = 0; i < N; ++i) {
            int lo = A[i];             // Track minimum in subarray starting at i
            int hi = A[i];             // Track maximum in subarray starting at i
            for (int j = i; j < N; ++j) {
                lo = min(lo, A[j]);    // Update minimum
                hi = max(hi, A[j]);    // Update maximum
                W[i][j] = hi - lo;     // Store the range for subarray A[i..j]
            }
        }

        // dp[i] = maximum score using first i elements with some number of partitions
        vector<ll> dp(N + 1, NINF);   // Initialize to negative infinity
        vector<ll> ndp(N + 1, NINF);  // Temporary DP array for next iteration
        dp[0] = 0;                     // Base case: 0 elements, score = 0
        ll ans = 0;                     // Variable to store the maximum answer

        // **Divide-and-Conquer DP optimization**
        // dnc(L, R, pL, pR) computes ndp[M] for M in [L..R]
        // assuming the optimal split point p is in [pL..pR]
        auto dnc = [&](auto&& self, int L, int R, int pL, int pR) -> void {
            if (L > R) return;         // Base case: empty segment, stop recursion
            int M = (L + R) / 2;       // Middle index, we compute ndp[M]

            ll bestv = NINF;           // Track best value for ndp[M]
            int bestp = pL;            // Track best split point

            // Try all possible split points p in [pL..pR]
            for (int p = pL; p <= M && p <= pR; ++p) {
                // dp[p-1] = best score for first (p-1) elements
                // W[p-1][M-1] = range of last subarray ending at M-1
                ll v = dp[p - 1] + (ll)W[p - 1][M - 1];
                if (v > bestv) {
                    bestv = v;         // Update best value
                    bestp = p;         // Update best split point
                }
            }

            ndp[M] = bestv;            // Store the optimal score for ndp[M]

            // Recurse on left half: L..M-1, optimal split point in [pL..bestp]
            self(self, L, M - 1, pL, bestp);
            // Recurse on right half: M+1..R, optimal split point in [bestp..pR]
            self(self, M + 1, R, bestp, pR);
        };

        // Main DP loop: build dp for 1..K partitions
        for (int i = 1; i <= K; ++i) {
            fill(begin(ndp), end(ndp), NINF);  // Reset ndp
            dnc(dnc, 1, N, 1, N);              // Compute ndp using divide-and-conquer DP
            dp.swap(ndp);                       // Move ndp into dp for next iteration
            ans = max(ans, dp[N]);              // Update maximum answer
        }

        return ans;                             // Return the best score for this linear array
    }

public:
    // Entry function: handles cyclic array
    ll maximumScore(vector<int>& A, int K) {
        // Step 1: Rotate array so that the minimum element is at the front
        int s = int(min_element(A.begin(), A.end()) - A.begin());
        rotate(A.begin(), A.begin() + s, A.end());

        ll ans = solve(A, K);               // Solve for this rotation

        // Step 2: Rotate by 1 more to consider another cyclic variant
        rotate(A.begin(), A.begin() + 1, A.end());
        ans = max(ans, solve(A, K));        // Solve again and take maximum

        return ans;                         // Return overall maximum score
    }
};
