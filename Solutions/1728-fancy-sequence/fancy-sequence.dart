class Fancy {

  // The modulo required by the problem
  // All operations must be performed mod (10^9 + 7)
  static const int MOD = 1000000007;

  // This list will store the sequence values.
  // IMPORTANT: we do NOT store the real values.
  // We store "normalized values" so we don't need to update the
  // whole array when addAll or multAll is called.
  List<int> seq = [];

  // mul represents the cumulative multiplication applied
  // to every element in the sequence.
  //
  // Example:
  // if we call multAll(2) then multAll(3)
  // the total multiplication is 2 * 3 = 6
  int mul = 1;

  // add represents the cumulative addition applied
  // to every element in the sequence.
  //
  // Example:
  // if we call addAll(3) then addAll(4)
  // the total addition is 3 + 4 = 7
  int add = 0;

  // Constructor
  // Initially the sequence is empty and there are
  // no transformations applied.
  Fancy();

  // APPEND OPERATION
  //
  // Add a number to the end of the sequence.
  void append(int val) {

    /*
      IMPORTANT IDEA

      Every value in the sequence is logically transformed as:

          realValue = storedValue * mul + add

      But we store only "storedValue".

      When we append a new value we must reverse the transformation
      so that the stored value behaves correctly when future
      operations are applied.

      We solve:

          val = stored * mul + add

      Rearranging:

          stored = (val - add) / mul

      Division under modulo is done using modular inverse.
    */

    // Step 1: remove the effect of the current addition
    int normalized = (val - add) % MOD;

    // Dart modulo can produce negative numbers
    // so we fix it if needed
    if (normalized < 0) {
      normalized += MOD;
    }

    // Step 2: remove the effect of the multiplication
    // division under modulo -> multiply by modular inverse
    normalized = (normalized * modInverse(mul)) % MOD;

    // Store the normalized value
    seq.add(normalized);
  }

  // ADDALL OPERATION
  //
  // Increase every value in the sequence by inc
  void addAll(int inc) {

    /*
      If the current transformation is:

          value = stored * mul + add

      After addAll(inc):

          value = stored * mul + (add + inc)

      So we only update the global "add".
      No need to update each element individually.
    */

    add = (add + inc) % MOD;
  }

  // MULTALL OPERATION
  //
  // Multiply every value in the sequence by m
  void multAll(int m) {

    /*
      If current transformation is:

          value = stored * mul + add

      After multiplying everything by m:

          value = (stored * mul + add) * m
                = stored * (mul * m) + (add * m)

      So we update both mul and add.
    */

    mul = (mul * m) % MOD;

    add = (add * m) % MOD;
  }

  // GETINDEX OPERATION
  //
  // Return the current value at position idx
  int getIndex(int idx) {

    // If index is outside the array we return -1
    if (idx >= seq.length) {
      return -1;
    }

    /*
      Retrieve the stored normalized value
      and apply the transformation:

          realValue = stored * mul + add
    */

    int stored = seq[idx];

    int result = ((stored * mul) % MOD + add) % MOD;

    return result;
  }

  // MODULAR INVERSE FUNCTION
  //
  // We use Fermat's Little Theorem:
  //
  //    a^(-1) mod p = a^(p-2) mod p
  //
  // because MOD is prime.
  int modInverse(int x) {
    return modPow(x, MOD - 2);
  }

  // FAST EXPONENTIATION (Binary Exponentiation)
  //
  // Computes:
  //
  //      base^exp % MOD
  //
  // in O(log exp) time.
  int modPow(int base, int exp) {

    int result = 1;

    // Reduce base under modulo first
    int b = base % MOD;

    while (exp > 0) {

      // If exp is odd multiply result
      if ((exp & 1) == 1) {
        result = (result * b) % MOD;
      }

      // Square the base
      b = (b * b) % MOD;

      // Divide exponent by 2
      exp >>= 1;
    }

    return result;
  }
}

/*
HOW THE STRUCTURE WORKS (EXAMPLE)

append(2)
seq = [2]

addAll(3)
logical values -> [5]

append(7)
seq stores normalized value for 7

multAll(2)
logical values -> [10, 14]

But internally we never modified the whole list.
We only updated the global transformation values
mul and add.

This makes every operation O(1).
*/