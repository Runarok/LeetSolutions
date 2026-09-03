class Solution {
    public boolean uniformArray(int[] nums1) {
        int smallestOdd = Integer.MAX_VALUE;
        int smallestEven = Integer.MAX_VALUE;
        boolean hasOdd = false;
        boolean hasEven = false;

        for (int num : nums1) {
            if ((num & 1) == 1) {
                hasOdd = true;
                smallestOdd = Math.min(smallestOdd, num);
            } else {
                hasEven = true;
                smallestEven = Math.min(smallestEven, num);
            }
        }

        // Already uniform.
        if (!hasOdd || !hasEven) {
            return true;
        }

        // We can make every even number odd using the smallest odd number.
        return smallestOdd < smallestEven;
    }
}
