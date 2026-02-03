public class Solution
{
    // A "trionic" array here means:
    // 1) strictly increasing
    // 2) strictly decreasing
    // 3) strictly increasing again
    // with all three parts non-empty
    public bool IsTrionic(int[] nums)
    {
        int n = nums.Length;

        // Pointer used to walk through the array
        int i = 1;

        // ---- First phase: strictly increasing ----
        // Move forward while the sequence is rising
        while (i < n && nums[i - 1] < nums[i])
        {
            i++;
        }

        // p marks the end index of the first increasing segment
        // If p == 0, then we never had a valid increasing part
        int p = i - 1;

        // ---- Second phase: strictly decreasing ----
        // Continue moving forward while the sequence is falling
        while (i < n && nums[i - 1] > nums[i])
        {
            i++;
        }

        // q marks the end index of the decreasing segment
        // If q == p, then there was no decreasing part
        int q = i - 1;

        // ---- Third phase: strictly increasing again ----
        // Continue while the sequence rises again
        while (i < n && nums[i - 1] < nums[i])
        {
            i++;
        }

        // flag should end exactly at the last index
        // Otherwise, extra elements break the trionic shape
        int flag = i - 1;

        // Final validation:
        // p != 0      -> first increasing part is non-empty
        // q != p      -> decreasing part is non-empty
        // flag == n-1 -> we consumed the entire array
        // flag != q   -> final increasing part is non-empty
        return (p != 0) &&
               (q != p) &&
               (flag == n - 1 && flag != q);
    }
}
