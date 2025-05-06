class Solution {

    /**
     * @param Integer[] $nums
     * @return Integer[]
     */
    function buildArray($nums) {
        $n = count($nums);  // Get the length of the input array
        
        // First pass: encode the result into nums
        for ($i = 0; $i < $n; $i++) {
            // We are encoding both the original value of nums[i] and the new value nums[nums[i]]
            // We store nums[nums[i]] in the higher part of nums[i] by adding (nums[nums[i]] % n) * n
            $nums[$i] += ($nums[$nums[$i]] % $n) * $n;
        }

        // Second pass: extract the encoded result and restore the original array
        for ($i = 0; $i < $n; $i++) {
            // To get the final value, we divide nums[i] by n (which gives us nums[nums[i]]).
            // We only need the quotient since it's the encoded value we stored.
            $nums[$i] = intdiv($nums[$i], $n);  
        }

        return $nums;  // Return the modified array which is now the result
    }
}
