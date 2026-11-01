
public class Solution {
    public int MinMoves(int[] nums) {
        int min = nums.Min();
        int moves = 0;

        foreach (int num in nums) {
            moves += num - min;
        }

        return moves;
    }
}
