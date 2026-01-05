using System;
using System.Collections.Generic;

public class RangeFreqQuery
{
    // Maps value -> list of indices where it appears
    private Dictionary<int, List<int>> positions;

    public RangeFreqQuery(int[] arr)
    {
        positions = new Dictionary<int, List<int>>();

        for (int i = 0; i < arr.Length; i++)
        {
            int val = arr[i];
            if (!positions.ContainsKey(val))
                positions[val] = new List<int>();
            positions[val].Add(i);
        }
    }

    /// <summary>
    /// Returns the frequency of `value` in subarray arr[left..right]
    /// </summary>
    public int Query(int left, int right, int value)
    {
        if (!positions.ContainsKey(value))
            return 0;

        List<int> idxList = positions[value];

        // Binary search: find the first index >= left
        int start = LowerBound(idxList, left);

        // Binary search: find the last index <= right
        int end = UpperBound(idxList, right) - 1;

        if (start > end) return 0;

        return end - start + 1;
    }

    /// <summary>
    /// Lower bound: first index in list >= target
    /// </summary>
    private int LowerBound(List<int> list, int target)
    {
        int low = 0, high = list.Count;
        while (low < high)
        {
            int mid = low + (high - low) / 2;
            if (list[mid] < target) low = mid + 1;
            else high = mid;
        }
        return low;
    }

    /// <summary>
    /// Upper bound: first index in list > target
    /// </summary>
    private int UpperBound(List<int> list, int target)
    {
        int low = 0, high = list.Count;
        while (low < high)
        {
            int mid = low + (high - low) / 2;
            if (list[mid] <= target) low = mid + 1;
            else high = mid;
        }
        return low;
    }
}

/**
Example Usage:

int[] arr = {12, 33, 4, 56, 22, 2, 34, 33, 22, 12, 34, 56};
RangeFreqQuery rfq = new RangeFreqQuery(arr);

rfq.Query(1, 2, 4);   // returns 1
rfq.Query(0, 11, 33); // returns 2
rfq.Query(0, 5, 100); // returns 0 (value not present)
*/
