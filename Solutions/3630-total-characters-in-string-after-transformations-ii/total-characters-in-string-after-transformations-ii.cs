public class Solution {
    // Constant MOD value to take results modulo 1e9 + 7
    private const int MOD = (int)1e9 + 7;
    
    // Constant L = 26 to represent the number of letters in the alphabet
    private const int L = 26;

    // Matrix class to handle 26x26 matrices representing character transformations
    private class Mat {
        // 2D array to hold the matrix values (size 26x26)
        public int[,] a = new int[L, L];

        // Default constructor to initialize matrix with zeros
        public Mat() {}

        // Copy constructor to create a deep copy of an existing matrix
        public Mat(Mat copyFrom) {
            for (int i = 0; i < L; i++) {
                for (int j = 0; j < L; j++) {
                    // Copy each element from the original matrix to the new matrix
                    this.a[i, j] = copyFrom.a[i, j];
                }
            }
        }

        // Matrix multiplication function to multiply two matrices and return the result
        public Mat Mul(Mat other) {
            // Create a new result matrix for the product
            Mat result = new Mat();
            
            // Perform matrix multiplication (result = this * other)
            for (int i = 0; i < L; i++) {
                for (int j = 0; j < L; j++) {
                    for (int k = 0; k < L; k++) {
                        // Add the product of corresponding elements, modulo MOD
                        result.a[i, j] =
                            (int)((result.a[i, j] +
                                   (long)this.a[i, k] * other.a[k, j]) % MOD);
                    }
                }
            }
            return result;
        }
    }

    /* Identity matrix function */
    // This function creates and returns an identity matrix of size 26x26
    private Mat I() {
        Mat m = new Mat();
        
        // Set the diagonal elements to 1, other elements remain 0
        for (int i = 0; i < L; i++) {
            m.a[i, i] = 1;
        }
        return m;
    }

    /* Matrix exponentiation by squaring */
    // This function computes the matrix 'x' raised to the power 'y' using binary exponentiation
    private Mat QuickMul(Mat x, int y) {
        // Initialize the result as the identity matrix
        Mat ans = I();
        
        // Initialize 'cur' as a copy of matrix 'x'
        Mat cur = new Mat(x);
        
        // Perform binary exponentiation to compute x^y
        while (y > 0) {
            if ((y & 1) == 1) {
                // If the current exponent bit is 1, multiply the result by 'cur'
                ans = ans.Mul(cur);
            }
            // Square 'cur' and reduce the exponent by half
            cur = cur.Mul(cur);
            y >>= 1;
        }
        return ans;
    }

    // Main function to calculate the length of the string after exactly 't' transformations
    public int LengthAfterTransformations(string s, int t, IList<int> nums) {
        // Initialize the transformation matrix T with size 26x26
        Mat T = new Mat();

        // Fill the transition matrix 'T' based on the given 'nums' array
        // Each row i in matrix T represents the character corresponding to 'i' ('a' + i)
        for (int i = 0; i < L; i++) {
            // For each character, fill in the corresponding transitions as described in 'nums[i]'
            for (int j = 1; j <= nums[i]; j++) {
                // Set the target character in the matrix, considering circular behavior (wraps around 'z')
                T.a[(i + j) % L, i] = 1;
            }
        }

        // Exponentiate the transformation matrix T to the power 't' using matrix exponentiation
        Mat res = QuickMul(T, t);

        // Create an array to count the frequency of each character in the input string 's'
        int[] f = new int[L];
        foreach (char ch in s) {
            // Increment the frequency of the corresponding character
            f[ch - 'a']++;
        }

        // Initialize the answer to 0, which will hold the final length of the transformed string
        int ans = 0;

        // Multiply the transformation matrix 'res' by the frequency vector 'f'
        // The result gives the new frequencies of the characters after t transformations
        for (int i = 0; i < L; i++) {
            for (int j = 0; j < L; j++) {
                // Multiply the frequency of character j with the transition value and add to the result
                ans = (int)((ans + (long)res.a[i, j] * f[j]) % MOD);
            }
        }

        // Return the result as the length of the transformed string modulo 1e9 + 7
        return ans;
    }
}
