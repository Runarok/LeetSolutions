// -------- Global DP and helper variables --------
long long DP[16][16][3][10][2]; // Memoization table for recursive DP
int EXACT;                       // Stores exact waviness for a number when FLAG = 0
int L;                           // Length of the number currently being processed
int D[16];                       // Digits of the number, stored in array

// -------- Recursive DP function --------
/*
POS: current position in the number we are filling (0-indexed)
LAST_DIGIT: the digit used in the previous position
RELATION_STATUS: 
    0 = previous digit < current digit (ascending)
    1 = previous digit > current digit (descending)
    2 = no previous relation (first digit)
WAVINESS: the number of "waviness" peaks so far
FLAG:
    0 = current number must be <= original number digit (tight constraint)
    1 = we can use any digit freely
*/
long long REC(int POS, int LAST_DIGIT, int RELATION_STATUS, int WAVINESS, int FLAG){
    // Base case: if we processed all digits
    if(POS == L){
        if(FLAG == 0){
            EXACT = WAVINESS; // store exact waviness for the given number
        }
        return WAVINESS;      // return the total waviness for this number
    }

    // Memoization check: if this state was already computed, return it
    if(DP[POS][WAVINESS][RELATION_STATUS][LAST_DIGIT][FLAG] != -1){
        return DP[POS][WAVINESS][RELATION_STATUS][LAST_DIGIT][FLAG];
    }

    long long sum = 0;  // Sum of waviness counts for all valid choices of current digit

    // Try all possible digits at current position
    for(int d = 0; d <= 9; d++){
        if(d == 0 && POS == 0) continue;           // Leading zeros are not allowed
        if(FLAG == 0 && D[POS] < d) continue;     // Tight constraint: cannot exceed original digit

        int NEW_FLAG = FLAG;                       // Determine new FLAG for next recursion
        if(D[POS] > d) NEW_FLAG = 1;              // Relax tight constraint if digit < original

        int NEW_WAVINESS = WAVINESS;              // Current waviness count

        // Check if we create a new "waviness" peak or valley
        if(RELATION_STATUS == 0 && LAST_DIGIT > d){ // previously ascending, now descending
            NEW_WAVINESS ++;
        }
        if(RELATION_STATUS == 1 && LAST_DIGIT < d){ // previously descending, now ascending
            NEW_WAVINESS ++;
        }

        int NEW_RELATION_STATUS = 2;             // Determine relation for next digit
        if(POS >= 1){                             // Only update after first digit
            if(LAST_DIGIT < d) NEW_RELATION_STATUS = 0; // ascending
            if(LAST_DIGIT > d) NEW_RELATION_STATUS = 1; // descending
        }

        // Recursive call for next position
        sum += REC(POS + 1, d, NEW_RELATION_STATUS, NEW_WAVINESS, NEW_FLAG);
    }

    // Save result in DP table
    DP[POS][WAVINESS][RELATION_STATUS][LAST_DIGIT][FLAG] = sum;
    return sum;
}

// -------- Helper function to convert a number into digit array --------
void add_to_D(long long x){
    memset(DP, -1, sizeof(DP)); // Reset DP table for new number
    L = 0;                       // Reset length
    while(x > 0){
        D[L++] = x % 10;         // Extract digits from right to left
        x /= 10;
    }
    reverse(D, D + L);           // Reverse digits to get correct order
}

// -------- Main Solution Class --------
class Solution {
public:
    long long totalWaviness(long long num1, long long num2) {
        // Precompute counts for all numbers of lengths 3..15
        long long p10 = 100;               // Start from 10^2 = 100
        long long cnt[16];                 // cnt[i] = number of waviness counts for length i numbers
        memset(cnt, 0, sizeof(cnt));

        for(int i = 3; i <= 15; i++){
            p10 *= 10;                      // 10^i
            add_to_D(p10 - 1);              // Consider all numbers with i digits: 0..10^i - 1
            cnt[i] = REC(0, 0, 2, 0, 0);    // Compute waviness for all numbers with length i
        }

        // -------- Compute waviness for num1 --------
        add_to_D(num1);
        long long s1 = REC(0, 0, 2, 0, 0);  // Total waviness for num1
        int e1 = EXACT;                      // Exact waviness for num1 itself

        // Add precomputed counts for numbers with fewer digits
        for(int i = 0; i < L; i++){
            s1 += cnt[i];
        }

        // -------- Compute waviness for num2 --------
        add_to_D(num2);
        long long s2 = REC(0, 0, 2, 0, 0);  // Total waviness for num2
        int e2 = EXACT;                      // Exact waviness for num2 itself

        // Add precomputed counts for numbers with fewer digits
        for(int i = 0; i < L; i++){
            s2 += cnt[i];
        }

        // Return total waviness in range [num1, num2]
        return s2 - s1 + e1;
    }
};
