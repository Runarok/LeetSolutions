public class Solution {
    public int[] SeparateDigits(int[] nums) {
        List<int> result = new List<int>();

        foreach (int num in nums) {
            foreach (char digit in num.ToString()) {
                result.Add(digit - '0');
            }
        }

        return result.ToArray();
    }
}