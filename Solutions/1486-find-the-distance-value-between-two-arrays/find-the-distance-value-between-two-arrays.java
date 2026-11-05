class Solution {
    public int findTheDistanceValue(int[] arr1, int[] arr2, int d) {
        // Initialize a counter to keep track of how many elements in arr1 
        // satisfy the distance condition.
        int distanceValueCount = 0;
        
        // Outer loop: Iterate through each element in the first array (arr1).
        for (int i = 0; i < arr1.length; i++) {
            
            // Assume the current element in arr1 is valid until we find 
            // an element in arr2 that violates the condition.
            boolean isValid = true;
            
            // Inner loop: Compare the current element of arr1 with every element in arr2.
            for (int j = 0; j < arr2.length; j++) {
                
                // Calculate the absolute difference between arr1[i] and arr2[j].
                int absoluteDifference = Math.abs(arr1[i] - arr2[j]);
                
                // Check if the absolute difference is less than or equal to d.
                // According to the problem, if |arr1[i] - arr2[j]| <= d, 
                // then arr1[i] is invalid and should not be counted.
                if (absoluteDifference <= d) {
                    isValid = false;
                    
                    // Optimization: Once we find any element in arr2 that violates 
                    // the condition, we can stop checking the rest of arr2.
                    break;
                }
            }
            
            // If the element from arr1 survived checking against all elements in arr2 
            // without violating the condition, it counts towards the distance value.
            if (isValid) {
                distanceValueCount++;
            }
        }
        
        // Return the total distance value count.
        return distanceValueCount;
    }
}