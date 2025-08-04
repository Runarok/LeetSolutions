import java.util.*;

class Solution {
    public int totalFruit(int[] fruits) {
        Map<Integer, Integer> basket = new HashMap<>();
        int left = 0;
        int max = 0;

        for (int right = 0; right < fruits.length; right++) {
            // Add the current fruit to the basket
            basket.put(fruits[right], basket.getOrDefault(fruits[right], 0) + 1);

            // If there are more than 2 types, shrink the window from the left
            while (basket.size() > 2) {
                basket.put(fruits[left], basket.get(fruits[left]) - 1);
                if (basket.get(fruits[left]) == 0) {
                    basket.remove(fruits[left]);
                }
                left++;
            }

            // Update the maximum number of fruits we can collect
            max = Math.max(max, right - left + 1);
        }

        return max;
    }
}
