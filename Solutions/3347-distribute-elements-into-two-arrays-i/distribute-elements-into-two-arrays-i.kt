class Solution {
    fun resultArray(nums: IntArray): IntArray {

        // Create the two arrays that will hold the elements.
        val arr1 = mutableListOf<Int>()
        val arr2 = mutableListOf<Int>()

        // The first element always goes into arr1.
        arr1.add(nums[0])

        // The second element always goes into arr2.
        arr2.add(nums[1])

        // Process the remaining elements one by one.
        for (i in 2 until nums.size) {

            // Get the last element currently present in arr1.
            val last1 = arr1[arr1.size - 1]

            // Get the last element currently present in arr2.
            val last2 = arr2[arr2.size - 1]

            // If arr1's last element is greater,
            // put the current number into arr1.
            if (last1 > last2) {
                arr1.add(nums[i])
            } else {
                // Otherwise, put it into arr2.
                arr2.add(nums[i])
            }
        }

        // The required result is arr1 followed by arr2.
        val result = IntArray(nums.size)
        var index = 0

        // Copy all elements of arr1 first.
        for (num in arr1) {
            result[index++] = num
        }

        // Then copy all elements of arr2.
        for (num in arr2) {
            result[index++] = num
        }

        // Return the concatenated array.
        return result
    }
}