class Solution {
public:
    int findKthNumber(int n, int k) {
        int prefix = 1;
        k--; // we start from 1, so first number is already counted
        
        while (k > 0) {
            long long steps = countPrefix(prefix, n);
            if (steps <= k) {
                // k-th number is not under this prefix, skip
                k -= steps;
                prefix++;
            } else {
                // k-th number is under this prefix, go deeper
                prefix *= 10;
                k--;
            }
        }
        
        return prefix;
    }
    
private:
    long long countPrefix(long long prefix, long long n) {
        long long cur = prefix;
        long long next = prefix + 1;
        long long count = 0;
        
        while (cur <= n) {
            count += min(n + 1LL, next) - cur;
            cur *= 10;
            next *= 10;
        }
        
        return count;
    }
};
