object Solution {

  /**
   * Given an integer n, returns the minimum number of operations
   * needed to transform n into 0 using the defined bit operations.
   *
   * Approach:
   *  - Recursive mathematical method
   *  - Uses properties of bit manipulation and Gray code symmetry
   */
  def minimumOneBitOperations(n: Int): Int = {

    // Base Case:
    // If n == 0, no operations are needed.
    if (n == 0) return 0

    // Step 1: Find the most significant bit (MSB) in n
    //
    // 'curr' will hold the value 2^k for the most significant bit
    // Example:
    //   If n = 6 (binary 110), then the MSB corresponds to 2^2 = 4.
    //   So curr will end up as 4, and k = 2.
    var curr = 1
    var k = 0
    while (curr * 2 <= n) {
      curr *= 2   // move to next bit (2^k)
      k += 1
    }

    // Step 2: Compute f(k)
    //
    // f(k) is the number of operations required to reduce 2^k -> 0.
    // We already know from the mathematical recurrence:
    //   f(k) = 2^(k+1) - 1
    val f_k = (1 << (k + 1)) - 1 // equivalent to 2^(k+1) - 1

    // Step 3: Compute n'
    //
    // n' = n XOR 2^k
    // This removes the MSB from n, leaving the remainder.
    // Example:
    //   n = 6 (110), curr = 4 (100)
    //   n' = 6 XOR 4 = 2 (010)
    val n_prime = n ^ curr

    // Step 4: Apply the recursive relationship
    //
    // ans = f(k) - A(n')
    // where A(n') = minimumOneBitOperations(n')
    //
    // Why subtraction?
    // Because when transforming from 2^k to 0, n lies “along the way”.
    // So the number of remaining operations is less than f(k),
    // by exactly A(n').
    val result = f_k - minimumOneBitOperations(n_prime)

    // Return the final result
    result
  }


  // -------- Optional: Small driver test --------
  def main(args: Array[String]): Unit = {
    val testCases = Seq(0, 1, 2, 3, 6, 9, 19, 42, 100)
    for (n <- testCases) {
      println(f"n = $n%-3d -> min ops = ${minimumOneBitOperations(n)}")
    }
  }
}
