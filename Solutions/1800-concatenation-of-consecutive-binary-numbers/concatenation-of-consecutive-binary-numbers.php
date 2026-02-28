class Solution {

    /**
     * @param Integer $n
     * @return Integer
     */
    function concatenatedBinary($n) {
        
        // We are required to return the result modulo 10^9 + 7
        // This is a common modulus used to prevent integer overflow
        $MOD = 1000000007;
        
        // This variable will store our final result
        $result = 0;
        
        // This keeps track of the current binary length
        // (number of bits needed to represent the current number)
        $bitLength = 0;
        
        // Loop from 1 to n
        for ($i = 1; $i <= $n; $i++) {
            
            /*
             * If $i is a power of 2, its binary length increases by 1.
             * Example:
             * 1  -> 1       (1 bit)
             * 2  -> 10      (2 bits)
             * 4  -> 100     (3 bits)
             * 8  -> 1000    (4 bits)
             * 
             * A number is a power of 2 if:
             * ($i & ($i - 1)) == 0
             * 
             * This works because powers of 2 have only one '1' bit.
             */
            if (($i & ($i - 1)) == 0) {
                $bitLength++;
            }
            
            /*
             * To concatenate a binary number:
             * 
             * Shifting left by $bitLength bits is equivalent to:
             * multiplying by 2^$bitLength
             * 
             * So:
             * result = (result << bitLength) + current number
             * 
             * We take modulo at every step to prevent overflow.
             */
            $result = (($result << $bitLength) + $i) % $MOD;
        }
        
        // Return the final computed value
        return $result;
    }
}